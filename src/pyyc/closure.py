import sys
import ast
from ast import *
from flat import *

class freeVarVisitor(ast.NodeVisitor):
    def __init__(self, scope=0):
        self.freeVars = set()
        self.scope = scope

    def visit_FunctionDef(self, node):
        return node

    def visit_Lambda(self, node):
        return node
    
    def visit_Name(self, node):
        # print(node.id)
        if (node.id != 'create_closure') and (node.id != 'set_free_vars'):
            varScope = int(node.id[len(node.id)-1])
            if (varScope != self.scope):
                self.freeVars.add(node.id)

class unifyLambdas(ast.NodeTransformer):
    def __init__(self):
        self.heapifyVars = set()
        self.lambdaCounter = 0
        self.lambdaAdds = []
        self.lambdaClosures = []
    
    def visit_Module(self, node):
        self.generic_visit(node)
        for i in self.lambdaAdds:
            node.body.insert(0, i)
        return node
    
    def visit_FunctionDef(self, node):
        for idx, x in enumerate(node.body):
            self.visit(x)
            if (len(self.lambdaClosures) > 0):
                for n in self.lambdaClosures:
                    node.body.insert(idx, n)
            
            self.lambdaClosures = []
        
        return node

    def visit_Lambda(self, node):
        self.generic_visit(node)

        if isinstance(node.parent, Assign):
            lambdaName = node.parent.targets[0].id
        else:
            lambdaName = 'lambda_' + str(node.funcScope)
            self.lambdaCounter = node.funcScope + 1
            # self.lambdaCounter += 1

        lambdaFunc = ast.FunctionDef(
            name=lambdaName,
            args=ast.arguments(
                posonlyargs=node.args.posonlyargs,
                args=node.args.args,
                kwonlyargs=node.args.kwonlyargs,
                kw_defaults=node.args.kw_defaults,
                defaults=node.args.defaults
            ),
            body=[ast.Return(
                value=node.body
            )],
            decorator_list=[]
        )

        lambdaFunc.varScope = node.varScope
        lambdaFunc.funcScope = node.funcScope

        self.lambdaAdds.insert(0, lambdaFunc)

        freeVarCounter = freeVarVisitor(node.varScope)
        freeVarCounter.visit(node.body)
        freeVars = list(freeVarCounter.freeVars)
        for x in freeVars:
            self.heapifyVars.add(x)

        freeVarsNodes = []
        for i in freeVars:
            freeVarsNodes.append(ast.Name(id=i, ctx=Load()))

        lambdaClosure = ast.Assign(
            targets=[ast.Name(id=lambdaName, ctx=Load())],
            value=ast.Call(
                func=ast.Name(id='create_closure', ctx=Load()), 
                args=[
                    ast.Name(id=lambdaName, ctx=Load()), 
                    List(
                        elts=[],
                        ctx=Load()
                    )
                ],
                keywords=[]
            )
        )

        self.lambdaClosures.insert(0, lambdaClosure)

        setFreesNode = ast.Assign(
            targets=[ast.Name(id=lambdaName, ctx=Load())],
            value=ast.Call(
                func=ast.Name(id='set_free_vars', ctx=Load()), 
                args=[
                    ast.Name(id=lambdaName, ctx=Load()), 
                    List(
                        elts=freeVarsNodes,
                        ctx=Load()
                    )
                ],
                keywords=[]
            )
        )

        self.lambdaClosures.insert(0, setFreesNode)

        replacementNode = ast.Name(id=lambdaName, ctx=Load())

        return replacementNode

class convertClosureCalls(ast.NodeTransformer):
    def __init__(self):
        self.runtimeFuncs = ['print', 'int', 'eval', 'input', 'create_closure', 'set_free_vars']
    
    def visit_Call(self, node):
        self.generic_visit(node)
        if (isinstance(node.func, Name) and (node.func.id not in self.runtimeFuncs)) or (isinstance(node.func, Subscript)):
            arguments=[
                ast.Call(
                    func=ast.Name(id='get_free_vars'),
                    args=[node.func],
                    keywords=[]
                )
            ]

            for i in node.args:
                arguments.append(i)

            replacementNode = ast.Call(
                func=ast.Call(
                    func=ast.Name(id='get_fun_ptr', ctx=Load()),
                    args=[node.func],
                    keywords=[]
                ),
                args=arguments, 
                keywords=[]
            )

            return replacementNode
        else:
            return node

class heapifyVisitor(ast.NodeTransformer):
    def __init__(self, heapifyVariables=[], heapifyArgs=[]):
        self.heapifyVars = heapifyVariables
        self.simpleNodes = [Name, Constant, List, Dict]
        self.closureFuncs = ['get_free_vars', 'get_fun_ptr', 'create_closure', 'set_free_vars']
        self.heapifyArgs = heapifyArgs
    
    def CheckSimplicity(self, node):
        for i in self.simpleNodes:
            if isinstance(node, i):
                return True
        
        return False

    def visit_Assign(self, node):
        self.generic_visit(node)
        if isinstance(node.value, Name) and (node.value.id in self.heapifyVars):
            node.value = ast.Subscript(
                value=ast.Name(id=node.value.id),
                slice=Constant(value=0),
                ctx=Load()
            )
        if isinstance(node.targets[0], Name) and (node.targets[0].id in self.heapifyVars) and self.CheckSimplicity(node.value):
                node.value = ast.List(
                    elts=[
                        node.value
                    ],
                    ctx=ast.Load()
                )
        
        return node
    
    def visit_Name(self, node):
        if (isinstance(node.parent, Assign) or (node.id in self.closureFuncs)):
            return node

        if (isinstance(node.parent, Call)):
            if (isinstance(node.parent.func, Name) and (node.parent.func.id in self.closureFuncs)):
                return node
        
        if (isinstance(node.parent, List) and isinstance(node.parent.parent, Call)):
            if (node.id not in self.heapifyArgs):
                return node
        
        if (node.id in self.heapifyVars) and isinstance(node.ctx, Load):
            if node.id in self.heapifyArgs:
                varname = node.id + 'H'
            else:
                varname = node.id

            replacementNode = ast.Subscript(
                value=ast.Name(id=varname, ctx=Load()), 
                slice=ast.Constant(value=0),
                ctx=Load()
            )
            return replacementNode
        
        return node
    
    def visit_FunctionDef(self, node):
        newFunctionBody = []
        for arg in node.args.args:
            if (arg.arg in self.heapifyVars):
                heapName = arg.arg + "H"
                heapNode = ast.Name(id=heapName, ctx=Load())
                newArgNode = ast.Assign(
                    targets=[heapNode], 
                    value = ast.List(
                        elts=[
                            ast.Name(id=arg.arg, ctx=Load())
                        ],
                        ctx=Load()
                    )
                )
                newFunctionBody.append(newArgNode)
                self.heapifyArgs.append(arg.arg)

        functionHeapify = heapifyVisitor(self.heapifyVars, self.heapifyArgs)

        for n in node.body:
            newNode = functionHeapify.visit(n)
            newFunctionBody.append(newNode)
        
        node.body = newFunctionBody
        
        for a in node.args.args:
            if a in self.heapifyArgs:
                self.heapifyArgs.remove(a)
        
        return node
        


class closureVisitor(ast.NodeTransformer):
    def __init__(self, lambdaCounter=0, heapifyVars=set()):
        self.newBody = []
        self.runtimeFuncs = ['print', 'eval', 'input', 'int']
        self.lambdaCounter = lambdaCounter
        self.closureAdds=[]
        self.heapifyVars = heapifyVars
    
    def visit_Module(self, node):
        self.generic_visit(node)
        node.body = self.newBody
        return node
    
    def visit_Assign(self, node):
        self.generic_visit(node)
        self.newBody.append(node)
        return node
        
    def visit_Expr(self, node):
        self.generic_visit(node)
        self.newBody.append(node)
        return node
    
    def visit_Return(self, node):
        self.generic_visit(node)
        self.newBody.append(node)
        return node
    
    def visit_While(self, node):
        testCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)

        newTest = testCloser.visit(node.test)
        node.test = newTest


        self.lambdaCounter = testCloser.lambdaCounter
        for j in testCloser.heapifyVars:
            self.heapifyVars.add(j)
        self.closureAdds += testCloser.closureAdds

        whileCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)

        newWhileBody = []
        for n in node.body:
            newNode = whileCloser.visit(n)
            newWhileBody.append(newNode)
        node.body = newWhileBody

        self.lambdaCounter = whileCloser.lambdaCounter
        for i in whileCloser.heapifyVars:
            self.heapifyVars.add(i)
        self.closureAdds += whileCloser.closureAdds

        self.newBody.append(node)
        return node

    def visit_If(self, node):
        testCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)

        newTest = testCloser.visit(node.test)
        node.test = newTest

        self.lambdaCounter = testCloser.lambdaCounter
        for k in testCloser.heapifyVars:
            self.heapifyVars.add(k)
        self.closureAdds += testCloser.closureAdds

        ifCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)
        newBody = []
        for n in node.body:
            newNode = ifCloser.visit(n)
            newBody.append(newNode)
        node.body = newBody

        self.lambdaCounter = ifCloser.lambdaCounter
        for j in ifCloser.heapifyVars:
            self.heapifyVars.add(j)
        self.closureAdds += ifCloser.closureAdds

        orElseCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)
        newOrElse = []
        for x in node.orelse:
            newNode = orElseCloser.visit(x)
            newOrElse.append(newNode)
        node.orelse = newOrElse

        self.lambdaCounter = orElseCloser.lambdaCounter
        for i in orElseCloser.heapifyVars:
            self.heapifyVars.add(i)
        self.closureAdds += orElseCloser.closureAdds

        self.newBody.append(node)
        return node

    def visit_IfExpr(self, node):
        testExprCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)

        newTest = testExprCloser.visit(node.test)
        node.test = newTest

        self.lambdaCounter = testExprCloser.lambdaCounter
        for i in testExprCloser.heapifyVars:
            self.heapifyVars.add(i)
        self.closureAdds += testExprCloser.closureAdds

        ifExprCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)
        newBody = []
        for n in node.body:
            newNode = ifExprCloser.visit(n)
            newBody.append(newNode)
        node.body = newBody

        self.lambdaCounter = ifExprCloser.lambdaCounter
        for j in ifExprCloser.heapifyVars:
            self.heapifyVars.add(j)
        self.closureAdds += ifExprCloser.closureAdds

        orElseExprCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)
        newOrElse = []
        for x in node.orelse:
            newNode = orElseExprCloser.visit(x)
            newOrElse.append(newNode)
        node.orelse = newOrElse

        self.lambdaCounter = orElseExprCloser.lambdaCounter
        for k in orElseExprCloser.heapifyVars:
            self.heapifyVars.add(k)
        self.closureAdds += orElseExprCloser.closureAdds

        self.newBody.append(node)
        return node


    def visit_FunctionDef(self, node):
        varScope = node.varScope
        functionScope = node.funcScope

        freeVarCounter = freeVarVisitor(varScope)
        for n in node.body:
            freeVarCounter.visit(n)
        freeVars = list(freeVarCounter.freeVars)
        for x in freeVars:
            self.heapifyVars.add(x)

        newFunctionBody = []
        for n in node.body:
            functionCloser = closureVisitor(self.lambdaCounter, self.heapifyVars)
            newNode = functionCloser.visit(n)
            for x in functionCloser.newBody:
                newFunctionBody.append(x)
            self.lambdaCounter = functionCloser.lambdaCounter
        node.body = newFunctionBody

        self.lambdaCounter = functionCloser.lambdaCounter
        for i in functionCloser.heapifyVars:
            self.heapifyVars.add(i)
        self.closureAdds += functionCloser.closureAdds

        freeVarsParam = ast.arg(arg='free_vars_' + str(self.lambdaCounter))

        for index, variable in enumerate(freeVars):
            freeAssignment = ast.Assign(
                targets=[ast.Name(id=variable, ctx=Load())],
                value=ast.Subscript(
                    value=ast.Name(id=freeVarsParam.arg, ctx=ast.Load()),
                    slice=ast.Constant(value=index),
                    ctx=Load()
                )
            )
            node.body.insert(0, freeAssignment)

        if (functionScope != 0):
            if (node.name[0:len(node.name)-1] != 'lambda_'):
                newArgs = node.args.args
                newArgs.insert(0, freeVarsParam)

                lambdaName = 'lambda_' + str(self.lambdaCounter)
                self.lambdaCounter += 1

                closedFunc = ast.FunctionDef(
                    name=lambdaName,
                    args=ast.arguments(
                        posonlyargs=node.args.posonlyargs,
                        args=newArgs,
                        kwonlyargs=node.args.kwonlyargs,
                        kw_defaults=node.args.kw_defaults,
                        defaults=node.args.defaults
                    ),
                    body=node.body,
                    decorator_list=node.decorator_list
                )
                self.closureAdds.append(closedFunc)

                freeVarsNodes = []
                for i in freeVars:
                    freeVarsNodes.append(ast.Name(id=i, ctx=Load()))

                closureNode = ast.Assign(
                    targets=[ast.Name(id=node.name, ctx=Load())],
                    value=ast.Call(
                        func=ast.Name(id='create_closure', ctx=Load()), 
                        args=[
                            ast.Name(id=lambdaName, ctx=Load()), 
                            List(
                                elts=[],
                                ctx=Load()
                            )
                        ],
                        keywords=[]
                    )
                )

                self.newBody.append(closureNode)

                setFreesNode = ast.Assign(
                    targets=[ast.Name(id=node.name, ctx=Load())],
                    value=ast.Call(
                        func=ast.Name(id='set_free_vars', ctx=Load()), 
                        args=[
                            ast.Name(id=node.name, ctx=Load()), 
                            List(
                                elts=freeVarsNodes,
                                ctx=Load()
                            )
                        ],
                        keywords=[]
                    )
                )

                self.newBody.append(setFreesNode)
                return node
            else:
                self.closureAdds.append(node)
        else:
            newArgs = node.args.args
            newArgs.insert(0, freeVarsParam)

            lambdaName = 'lambda_' + str(self.lambdaCounter)
            self.lambdaCounter += 1

            closedFunc = ast.FunctionDef(
                name=lambdaName,
                args=ast.arguments(
                    posonlyargs=node.args.posonlyargs,
                    args=newArgs,
                    kwonlyargs=node.args.kwonlyargs,
                    kw_defaults=node.args.kw_defaults,
                    defaults=node.args.defaults
                ),
                body=node.body,
                decorator_list=node.decorator_list
            )

            freeVarsNodes = []
            for i in freeVars:
                freeVarsNodes.append(ast.Name(id=i, ctx=Load()))

            closureNode = ast.Assign(
                targets=[ast.Name(id=node.name, ctx=Load())],
                value=ast.Call(
                    func=ast.Name(id='create_closure', ctx=Load()), 
                    args=[
                        ast.Name(id=lambdaName, ctx=Load()), 
                        List(
                            elts=[],
                            ctx=Load()
                        )
                    ],
                    keywords=[]
                )
            )

            setFreesNode = ast.Assign(
                targets=[ast.Name(id=node.name, ctx=Load())],
                value=ast.Call(
                    func=ast.Name(id='set_free_vars', ctx=Load()), 
                    args=[
                        ast.Name(id=node.name, ctx=Load()), 
                        List(
                            elts=freeVarsNodes,
                            ctx=Load()
                        )
                    ],
                    keywords=[]
                )
            )

            for x in self.closureAdds:
                self.newBody.append(x)
            
            self.newBody.append(closedFunc)
            self.newBody.append(closureNode)
            self.newBody.append(setFreesNode)
            self.closureAdds=[]

        return node

