import sys
import ast
from ast import *

class uniquifyVisitor(ast.NodeTransformer):
    def __init__(self, currentScope=0, prevUsedScope=0, parentScopes=[], scopeDict={}, parameterVars=[]):
        self.currScope = currentScope
        self.prevUsedScope = prevUsedScope
        self.parentScopes = parentScopes
        self.scopeDict = scopeDict
        if (self.currScope in self.scopeDict.keys()):
            currVars = self.scopeDict[self.currScope]
            currVars += parameterVars
        else:
            currVars = parameterVars
        self.scopeDict.update({currentScope: currVars})
        self.runtimeFuncs = ['print', 'eval', 'input', 'int']

    def getVariableScope(self, variable):
        lastInstance = -1
        for i in self.parentScopes:
            if (variable in self.scopeDict[i]) and (i > lastInstance):
                lastInstance = i

        return lastInstance
        
    def visit_Module(self, node):
        self.generic_visit(node)
        return node

    def visit_Assign(self, node):
        self.generic_visit(node)
        return node
    
    def visit_FunctionDef(self, node):
        nextScope = self.prevUsedScope + 1
        currScopeVars = self.scopeDict[self.currScope]

        currScopeVars.append(node.name)
        self.scopeDict.update({self.currScope: currScopeVars})
        node.name = node.name + str(self.currScope) 

        parameterVars = []
        for arg in node.args.args:
            parameterVars.append(arg.arg)
            arg.arg = arg.arg + str(nextScope)

        nextParentScopes = self.parentScopes
        nextParentScopes.append(self.currScope)
    
        functionUniquify = uniquifyVisitor(nextScope, nextScope, nextParentScopes, self.scopeDict, parameterVars)

        newFunctionBody = []
        for n in node.body:
            newNode = functionUniquify.visit(n) 
            newFunctionBody.append(newNode)
        
        node.body = newFunctionBody
        
        self.prevUsedScope = functionUniquify.prevUsedScope
        node.varScope = nextScope
        node.funcScope = self.currScope

        return node
    
    def visit_Lambda(self, node):
        nextScope = self.prevUsedScope + 1
        parameterVars = []
        for arg in node.args.args:
            parameterVars.append(arg.arg)
            arg.arg = arg.arg + str(nextScope)

        nextParentScopes = self.parentScopes
        nextParentScopes.append(self.currScope)
        
        lambdaUniquify = uniquifyVisitor(nextScope, nextScope, nextParentScopes, self.scopeDict, parameterVars)

        newLambdaBody = lambdaUniquify.visit(node.body) 
        
        node.body = newLambdaBody

        self.prevUsedScope = lambdaUniquify.prevUsedScope
        node.varScope = nextScope
        node.funcScope = self.currScope

        return node
    
    def visit_Return(self, node):
        self.generic_visit(node)
        return node

    def visit_Call(self, node):
        if ((isinstance(node.func, Name)) and (node.func.id not in self.runtimeFuncs)) or (isinstance(node.func, Call) or (isinstance(node.func, Lambda))):
            node.func = self.visit(node.func)
        
        for n in node.args:
            if isinstance(n, Name):
                newNode = self.visit(n)
            else:
                newNode = self.generic_visit(n)

        return node

    def visit_Name(self, node):
        if (node.id not in self.runtimeFuncs):
            if (node.id == 't'):
                varname = '_t'
            else:
                varname = node.id
            currScopeVars = self.scopeDict[self.currScope]
            globalVars = self.scopeDict[0]
            if (varname in currScopeVars):
                node.id = varname + str(self.currScope)
                return node
            else:
                prevInstance = self.getVariableScope(varname)
                if (prevInstance == -1):
                    if (isinstance(node.parent, Assign)) and (node.parent.targets[0].id == node.id):
                        currScopeVars.append(varname)
                        self.scopeDict.update({self.currScope: currScopeVars})
                        node.id = varname + str(self.currScope)
                    else:
                        globalVars.append(varname)
                        self.scopeDict.update({0: globalVars})
                        node.id = varname + str(0)
                    return node
                else:
                    if (isinstance(node.parent, Assign)) and (node.parent.targets[0].id == node.id):
                        currScopeVars.append(varname)
                        self.scopeDict.update({self.currScope: currScopeVars})
                        node.id = varname + str(self.currScope)
                    else:
                        node.id = varname + str(prevInstance)
                    return node
        else:
            return node

class functionCounter(ast.NodeVisitor):
    def __init__(self):
        self.functions = []
    
    def visit_FunctionDef(self, node):
        self.generic_visit(node)
        if (node.name not in self.functions):
            self.functions.append(node.name)


class functionRearranger(ast.NodeTransformer):
    def __init__(self, undeclaredFunctions):
        self.undeclaredFunctions = undeclaredFunctions
        self.declaredFunctions = []
        self.disputedFunctions = []
        self.newBody = []

    def getBodyIndex(self, function):
        for idx, node in enumerate(self.newBody):
            if (isinstance(node, FunctionDef) and (node.name == function)):
                return idx
        
        return -1
    
    def visit_Module(self, node):
        self.newBody = []
        for i in node.body:
            self.newBody.append(i)
        self.generic_visit(node)
        node.body = self.newBody
        return node

    # def visit_Assign(self, node):
    #     if (isinstance(node.value, Call) and (node.value.id == 'create_closure')):
    #         freeVars = node.value.args[0]
    #         for i in freeVars:
    #             if i in 
    
    def visit_FunctionDef(self, node):
        self.generic_visit(node)
        # print(node.name)
        # print(self.disputedFunctions)
        # print('\n')

        if (node.name not in self.declaredFunctions):
            self.declaredFunctions.append(node.name)
        
        if (node.name in self.undeclaredFunctions):
            self.undeclaredFunctions.remove(node.name)
        
        # return node

        if isinstance(node.parent, Module):
            if (len(self.disputedFunctions) == 0):
                self.newBody.remove(node)
                self.newBody.insert(0, node)
                return node
            else:
                self.disputedFunctions = []
                return node
        else:
            return node

    def visit_Name(self, node):
        if (isinstance(node.parent, Call)) and (node.id in self.undeclaredFunctions) and (node.id not in self.disputedFunctions):
            self.disputedFunctions.append(node.id)

        return node        

        

        


            
        
            

            