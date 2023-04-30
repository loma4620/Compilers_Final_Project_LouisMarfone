import ast
from ast import *

class desugaringVisitor(ast.NodeTransformer):
    def __init__(self, currTempCount=0):
        super().__init__()
        self.tempCount = currTempCount
        self.newBody = []
        self.functions = ['print', 'input', 'eval', 'int']
        self.simpleNodes = [Constant, Name]


    def appendTemp(self, temp):
        #insert new temp node into Module's body where 
        self.newBody.append(temp)
            
        #replace complex operation in original binop with the temp variable using node transformer class
        replacementNode = ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Load())
        
        #increment number of temp variables we have
        self.tempCount += 1

        return replacementNode
    
    #this function flattens and desugars boolean operations
    def BooleanDesugar(self, node):
        simpleInputs = True
        if isinstance(node, BoolOp):
            for value in node.values:
                if (not self.checkSimplicity(value)):
                    simpleInputs = False
        elif isinstance(node, Assign):
            for value in node.value.values:
                if (not self.checkSimplicity(value)):
                    simpleInputs = False
        elif isinstance(node, Call):
            for value in node.args[0].values:
                if (not self.checkSimplicity(value)):
                    simpleInputs = False
        
        if simpleInputs:
            if isinstance(node, BoolOp):
                currValues = node.values

                left = currValues[0]
                right = currValues[1]
                if isinstance(node.op, Or):
                    if isinstance(left, Constant):
                        tempNode0 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)
                        left = self.appendTemp(tempNode0)
                    tempNode = ast.If(test=left, body= [ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)], orelse=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=right)])
                    self.tempCount += 1
                elif isinstance(node.op, And):
                    if isinstance(left, Constant):
                        tempNode0 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)
                        left = self.appendTemp(tempNode0)
                    tempNode1 = ast.If(test=left, body=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=Constant(value=0))], orelse=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=Constant(value=1))])
                    notLeft = self.appendTemp(tempNode1)
                    tempNode = ast.If(test=notLeft, body=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)], orelse=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=right)])
                    self.tempCount += 1
                
                self.newBody.append(tempNode)
            elif isinstance(node, Assign):
                currValues = node.value.values
                
                left = currValues[0]
                right = currValues[1]
                if isinstance(node.value.op, Or):
                    if isinstance(left, Constant):
                        tempNode0 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)
                        left = self.appendTemp(tempNode0)
                    tempNode = ast.If(test=left, body= [ast.Assign(targets=node.targets, value=left)], orelse=[ast.Assign(targets=node.targets, value=right)])
                elif isinstance(node.value.op, And):
                    if isinstance(left, Constant):
                        tempNode0 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)
                        left = self.appendTemp(tempNode0)
                    tempNode1 = ast.If(test=left, body=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=Constant(value=0))], orelse=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=Constant(value=1))])
                    notLeft = self.appendTemp(tempNode1)
                    tempNode = ast.If(test=notLeft, body=[ast.Assign(targets=node.targets, value=left)], orelse=[ast.Assign(targets=node.targets, value=right)])

                self.newBody.append(tempNode)
            elif isinstance(node, Call):
                currValues = node.args[0].values

                left = currValues[len(currValues)-2]
                right = currValues[len(currValues)-1]

                if isinstance(node.args[0].op, Or):
                    if isinstance(left, Constant):
                        tempNode0 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)
                        left = self.appendTemp(tempNode0)
                    tempNode = ast.If(test=left, body= [ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)], orelse=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=right)])
                    self.tempCount += 1
                elif isinstance(node.args[0].op, And):
                    if isinstance(left, Constant):
                        tempNode0 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)
                        left = self.appendTemp(tempNode0)
                    tempNode1 = ast.If(test=left, body=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=Constant(value=0))], orelse=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=Constant(value=1))])
                    notLeft = self.appendTemp(tempNode1)
                    tempNode = ast.If(test=notLeft, body=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=left)], orelse=[ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=right)])
                    self.tempCount += 1

                self.newBody.append(tempNode)

    #function used in visit_BinOp to check if left and right are simple or need to be flattened
    def checkSimplicity(self, node):
        for i in self.simpleNodes:
            if isinstance(node, i):
                return True
        return False
        
    
    def visit_Module(self, node):
        self.generic_visit(node)
        node.body = self.newBody
        return node

    def visit_Expr(self, node):
        self.generic_visit(node)
        self.newBody.append(node)
        return node

    def visit_Assign(self, node):
        
        self.generic_visit(node)
        
        if isinstance(node.value, BoolOp):
            replacementNode = self.BooleanDesugar(node)
        else:
            self.newBody.append(node)

        return node

    def visit_Constant(self, node):
        return node
        
    def visit_Name(self, node):
        return node

    def visit_BinOp(self, node):
        #call generic visit to implement depth first traversal of AST
        self.generic_visit(node)
        return node

    def visit_UnaryOp(self, node):
        self.generic_visit(node)
        return node
    
    def visit_Call(self, node):
        self.generic_visit(node)

        #int casts for comparisons
        if (node.func.id == 'int'):
            if isinstance(node.args[0], BoolOp):
                replacementNode = self.BooleanDesugar(node)
        
        return node

    def visit_Compare(self, node):
        self.generic_visit(node)
            
        return node

    def visit_If(self, node):
        newConditionalBody = []
        newConditionalOrelse = []
        newTest = self.visit(node.test)
        node.test = newTest

        for i in range(len(node.body)):
            If_Body_Desugar = desugaringVisitor(self.tempCount)
            Body_Node = If_Body_Desugar.visit(node.body[i])
            nextElement = If_Body_Desugar.newBody
            for element in nextElement:
                newConditionalBody.append(element)
            self.tempCount = If_Body_Desugar.tempCount
        node.body = newConditionalBody

        for i in range(len(node.orelse)):
            If_Orelse_Desugar = desugaringVisitor(self.tempCount)
            Orelse_Node = If_Orelse_Desugar.visit(node.orelse[i])
            nextElement = If_Orelse_Desugar.newBody
            for element in nextElement:
                newConditionalOrelse.append(element)
            self.tempCount = If_Orelse_Desugar.tempCount
        node.orelse = newConditionalOrelse

        self.newBody.append(node)
        return node
    
    def visit_While(self, node):
        newLoopBody = []

        for i in range(len(node.body)):
            While_Desugar = desugaringVisitor(self.tempCount)
            While_Node = While_Desugar.visit(node.body[i])
            nextElement = While_Desugar.newBody
            for element in nextElement:
                newLoopBody.append(element)
            self.tempCount = While_Desugar.tempCount
        node.body = newLoopBody

        self.newBody.append(node)
        return node
    
    def visit_Eq(self, node):
        self.generic_visit(node)
        return node
    
    def visit_NotEq(self, node):
        self.generic_visit(node)
        return node
    
    def visit_Not(self, node):
        self.generic_visit(node)
        return node

    def visit_BoolOp(self, node):
        self.generic_visit(node)

        simpleInputs = True
        for value in node.values:
            if (not self.checkSimplicity(value)):
                simpleInputs = False

        if simpleInputs:
            #edge case where BoolOp is an assignment and does not need to be simplified even though the first if statement is passed
            if isinstance(node.parent, Assign) or isinstance(node.parent, Call):
                return node 
            replacementNode = self.BooleanDesugar(node)
        
            return replacementNode
        return node

    def visit_FunctionDef(self, node):
        newFunctionBody = []

        for i in range(len(node.body)):
            Function_Desugar = desugaringVisitor(self.tempCount)
            Function_Node = Function_Desugar.visit(node.body[i])
            nextElement = Function_Desugar.newBody
            for element in nextElement:
                newFunctionBody.append(element)
            self.tempCount = Function_Desugar.tempCount
        node.body = newFunctionBody

        self.newBody.append(node)
        return node
    
    def visit_Return(self, node):
        self.generic_visit(node)
        self.newBody.append(node)
        return node