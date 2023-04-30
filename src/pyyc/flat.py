import ast
from ast import *

#flattening class using node transformer to enable Depth First traversal
class flatteningVisitor(ast.NodeTransformer):
    def __init__(self, currTempCount=0):
        super().__init__()
        self.tempCount = currTempCount
        self.newBody = []
        self.functions = ['print', 'input', 'eval', 'int']
        self.simpleNodes = [Constant, Name]
        self.runtimefunctions = []
        self.typeFuncs = ['tag', 'is_int', 'is_bool', 'is_float', 'is_big', 'is_function', 'is_object', 'is_class', 'is_unbound_method', 'is_bound_method']
        self.injectFuncs = ['inject_int', 'inject_bool', 'inject_float', 'inject_big']
        self.projectFuncs = ['project_int', 'project_bool', 'project_float', 'project_big', 'project_function', 'project_class', 'project_object', 'project_bound_method', 'project_unbound_method']
        self.runtimefunctions += self.typeFuncs
        self.runtimefunctions += self.injectFuncs
        self.runtimefunctions += self.projectFuncs
        self.runtimefunctions += 'error_pyobj'
        self.callDict = {}


    def appendTemp(self, temp):
        #insert new temp node into Module's body where 
        self.newBody.append(temp)
            
        #replace complex operation in original binop with the temp variable using node transformer class
        replacementNode = ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Load())
        
        #increment number of temp variables we have
        self.tempCount += 1

        return replacementNode
    
    #this function flattens and desugars boolean operations
    def BooleanReplacement(self, node):
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
                while (len(currValues) != 1):
                    left = currValues[len(currValues)-2]
                    right = currValues[len(currValues)-1]
                    
                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=BoolOp(op=node.op, values=[left, right]))
                    
                    replacementNode = self.appendTemp(tempNode)
                    
                    currValues.pop(len(currValues)-2)
                    currValues.pop(len(currValues)-1)
                    currValues.append(replacementNode)
                return replacementNode
            elif isinstance(node, Assign):
                currValues = node.value.values
                while (len(currValues) > 2):
                    left = currValues[len(currValues)-2]
                    right = currValues[len(currValues)-1]

                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=BoolOp(op=node.value.op, values=[left, right]))
                    
                    replacementNode = self.appendTemp(tempNode)

                    currValues.pop(len(currValues)-2)
                    currValues.pop(len(currValues)-1)
                    currValues.append(replacementNode)
                
                node.value.values = currValues
                return node
            elif isinstance(node, Call):
                currValues = node.args[0].values
                while (len(currValues) != 1):
                    left = currValues[len(currValues)-2]
                    right = currValues[len(currValues)-1]
                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=BoolOp(op=node.args[0].op, values=[left, right]))

                    replacementNode = self.appendTemp(tempNode)
                    currValues.pop(len(currValues)-2)
                    currValues.pop(len(currValues)-1)
                    currValues.append(replacementNode)

                return replacementNode
    
    #functions used in visit_Call to node identifies a varaible, if so an _ is added to the front of the variable
    def checkNameId(self, node):
        for i in self.functions:
            if (node.id == i):
                return True 
        return False 
    
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
            if (isinstance(node.targets[0], Name)):
                replacementNode = self.BooleanReplacement(node)
                self.newBody.append(replacementNode)
        elif isinstance(node.value, IfExp):
            if (not self.checkSimplicity(node.value.test)):
                newTest = self.visit(node.value.test)
            else:
                newTest = node.value.test

            bodyAssign = ast.Assign(
                targets=[node.targets[0]], 
                value=node.value.body,
            )

            newTernaryBody = []
            ternaryFlattener = flatteningVisitor(self.tempCount)
            ternaryParentAdder = ParentAdder()
            ternaryParentAdder.visit(bodyAssign)
            Body_Node = ternaryFlattener.visit(bodyAssign)
            nextElement = ternaryFlattener.newBody
            for element in nextElement:
                newTernaryBody.append(element)
            self.tempCount = ternaryFlattener.tempCount

            elseAssign = ast.Assign(
                targets=[node.targets[0]], 
                value=node.value.orelse,
            )
            
            newTernaryOrelse = []
            ternaryOrelseParentAdder = ParentAdder()
            ternaryOrelseParentAdder.visit(elseAssign)
            ternaryElseFlattener = flatteningVisitor(self.tempCount)
            Else_Node = ternaryElseFlattener.visit(elseAssign)
            nextElement = ternaryElseFlattener.newBody
            for element in nextElement:
                newTernaryOrelse.append(element)
            self.tempCount = ternaryElseFlattener.tempCount

            replacementNode = ast.If(
                test=newTest,
                body=newTernaryBody,
                orelse=newTernaryOrelse
            )

            self.newBody.append(replacementNode)
        else:
            if (isinstance(node.targets[0], Name)):
                if not(isinstance(node.value, Name) and (node.value.id == node.targets[0].id)):
                    self.newBody.append(node)
            else:
                self.newBody.append(node)
        
        if (not isinstance(node.targets[0], Name)) and (not self.checkSimplicity(node.value)):
            tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node.value)

            replacementNode = self.appendTemp(tempNode)

            node.value = replacementNode
            self.newBody.append(node)
                    
        return node
        
    def visit_Constant(self, node):
        return node
        
    def visit_Name(self, node):
        return node
        
    def visit_BinOp(self, node):
        #call generic visit to implement depth first traversal of AST
        self.generic_visit(node)

        #check if left and right are complex aka. a constant value or a variable
        if isinstance(node.parent, Assign):
            return node
        
        #create new temp node
        tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

        replacementNode = self.appendTemp(tempNode)
    
        return replacementNode
    
        
    def visit_UnaryOp(self, node):
        self.generic_visit(node)
        #base case: operand is not complex aka. a constant value or a variable
        if isinstance(node.op, Not) and (not isinstance(node.operand, List)) and (not isinstance(node.operand, Dict)):
            if (not isinstance(node.parent, Call)) or (isinstance(node.parent, Call) and node.parent.func.id != 'int'):
                target = ''
                if isinstance(node.parent, Assign):
                    target = node.parent.targets[0]
                else:
                    target = ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())
                if not isinstance(node.operand, Constant):
                        tempNode = ast.If(
                            test=ast.Name(node.operand.id),
                            body=[ast.Assign(targets=[target], value=ast.Constant(value=False))], 
                            orelse=[ast.Assign(targets=[target], value=ast.Constant(value=True))]
                        )
                else:
                    tempNode0 = ast.Assign(targets=[target], value=node.operand)
                    self.newBody.append(tempNode0)
                    # operand = self.appendTemp(tempNode0)
                    tempNode = ast.If(
                        test=target,
                        body=[ast.Assign(targets=[target], value=ast.Constant(value=False))], 
                        orelse=[ast.Assign(targets=[target], value=ast.Constant(value=True))]
                    )
                
                replacementNode = self.appendTemp(tempNode)
                if isinstance(node.parent, Assign):
                    replacementNode = target
                
                return replacementNode
            else:
                return node
        elif isinstance(node.op, Not) and (isinstance(node.operand, List) or isinstance(node.operand, Dict)):
                #create new temp node
                tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

                replacementNode = self.appendTemp(tempNode)
                
                return replacementNode

        if isinstance(node.op, USub) and self.checkSimplicity(node.operand):
            #edge case where BinOp is an assignment and does not need to be simplified even though the first if statement is passed
            if isinstance(node.parent, Assign):
                return node
            
            #create new temp node
            tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

            replacementNode = self.appendTemp(tempNode)
            
            return replacementNode
        
        return node

        
    def visit_Call(self, node):
        self.generic_visit(node)

        if (isinstance(node.func, Name)):
            # if (node.func.id == 'get_fun_ptr'):
            #     tempName = 't' + str(self.tempCount)
            #     if (tempName not in self.callDict.keys()):
            #         self.callDict.update[tempName: node.func.args[0].id]
                
            #     tempNode = ast.Assign(targets=[ast.Name(id=(tempName), ctx=ast.Store())], value=node)

            #     replacementNode = self.appendTemp(tempNode)
                
            #     return replacementNode
            if ((node.func.id == 'get_free_vars') or (node.func.id == 'get_function') or ((node.func.id not in self.runtimefunctions) and (node.func.id not in self.functions))):
                if (not (isinstance(node.parent, Assign) or isinstance(node.parent, Expr))):
                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

                    replacementNode = self.appendTemp(tempNode)
                    
                    return replacementNode
            elif (node.func.id in self.runtimefunctions):
                if isinstance(node.args[0], BoolOp):
                    boolNode = self.BooleanReplacement(node)
                    if isinstance(node.parent, Assign):
                        replacementNode = ast.Call(func=ast.Name(id=node.func.id, ctx=Load()), args=[boolNode], keywords=[])
                    else:
                        tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Load())], value=ast.Call(func=ast.Name(id=node.func.id, ctx=Load()), args=[boolNode], keywords=[]))
                        replacementNode = self.appendTemp(tempNode)
                    return replacementNode
                if isinstance(node.args[0], Compare):
                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node.args[0])
                    compareNode = self.appendTemp(tempNode)
                    if isinstance(node.parent, Assign):
                        replacementNode = ast.Call(func=ast.Name(id=node.func.id, ctx=Load()), args=[compareNode], keywords=[])
                    else:
                        tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Load())], value=ast.Call(func=ast.Name(id=node.func.id, ctx=Load()), args=[compareNode], keywords=[]))
                        replacementNode = self.appendTemp(tempNode)
                        
                    return replacementNode
                
            elif (node.func.id == 'int'):
                if isinstance(node.args[0], BoolOp):
                    boolNode = self.BooleanReplacement(node)
                    if isinstance(node.parent, Assign):
                        replacementNode = ast.Call(func=ast.Name(id='int', ctx=Load()), args=[boolNode], keywords=[])
                    else:
                        tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Load())], value=ast.Call(func=ast.Name(id='int', ctx=Load()), args=[boolNode], keywords=[]))
                        replacementNode = self.appendTemp(tempNode)
                    return replacementNode
                
                elif (isinstance(node.args[0], UnaryOp) and self.checkSimplicity(node.args[0].operand)):
                    target = ''
                    if isinstance(node.parent, Assign):
                        target = node.parent.targets[0]
                    else:
                        target = ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())
                        self.tempCount += 1

                    # tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)
                    if not isinstance(node.args[0].operand, Constant):
                        tempNode = ast.If(
                            test=ast.Name(id=node.args[0].operand.id, ctx=Load()),
                            body=[ast.Assign(targets=[target], value=ast.Constant(value=0))], 
                            orelse=[ast.Assign(targets=[target], value=ast.Constant(value=1))]
                        )
                    else:
                        tempNode0 = ast.Assign(targets=[target], value=node.args[0].operand)
                        self.newBody.append(tempNode0)
                        # operand = self.appendTemp(tempNode0)
                        tempNode = ast.If(
                            test=target,
                            body=[ast.Assign(targets=[target], value=ast.Constant(value=0))], 
                            orelse=[ast.Assign(targets=[target], value=ast.Constant(value=1))]
                        )

                    self.newBody.append(tempNode)

                    return target
                elif isinstance(node.args[0], Compare):
                    if isinstance(node.parent, Assign):
                        return node

                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)
                    
                    replacementNode = self.appendTemp(tempNode)
                    
                    return replacementNode
            elif (node.func.id == 'print'):
                if isinstance(node.args[0], BoolOp):
                    replacementNode = self.BooleanReplacement(node)
                    callRepNode = ast.Call(func=Name(id='print', ctx=Load()), args=[replacementNode], keywords=[])
                    return callRepNode
                elif (isinstance(node.args[0], Compare) or isinstance(node.args[0], UnaryOp)):
                    printNode = node.args[0]
                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=printNode)
                    replacementNode = self.appendTemp(tempNode)
                    node.args[0] = replacementNode
                    return node
            elif (node.func.id in self.typeFuncs):
                tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)
                
                replacementNode = self.appendTemp(tempNode)

                return replacementNode

            # Don't simplify if child of Expr or Assign, or if n.id == 'input' and n.parent.id == 'eval'
            if not isinstance(node.parent, Expr) and not isinstance(node.parent, Assign):
                if not (isinstance(node.parent, Call) and (node.func.id == 'input') and (node.parent.func.id == 'eval')):
                    #create new temp node
                    tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

                    replacementNode = self.appendTemp(tempNode)
                
                    return replacementNode
        
        return node    
    
    def visit_Compare(self, node):
        self.generic_visit(node)
        if isinstance(node.comparators[0], Constant):
            extraTemp1 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node.left)
            nodeValue1 = self.appendTemp(extraTemp1)
            extraTemp2 = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node.comparators[0])
            nodeValue2 = self.appendTemp(extraTemp2)
            node.left = nodeValue1
            node.comparators[0] = nodeValue2
        
        if isinstance(node.parent, UnaryOp) and isinstance(node.parent.op, Not):
            tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)
                
            replacementNode = self.appendTemp(tempNode)
            
            return replacementNode
        
        if (not isinstance(node.parent, Call)):
            if (isinstance(node.ops[0], Is)):
                #create new temp node
                tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)
                
                replacementNode = self.appendTemp(tempNode)
                
                return replacementNode
            elif (self.checkSimplicity(node.left) and self.checkSimplicity(node.comparators[0])):
                #create new temp node
                tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=Call(func=Name(id='int', ctx=Load()), args=[node], keywords=[]))
                
                replacementNode = self.appendTemp(tempNode)
                
                return replacementNode
            
        return node

    def visit_If(self, node):
        newConditionalBody = []
        newConditionalOrelse = []
        newTest = self.visit(node.test)
        node.test = newTest

        for i in range(len(node.body)):
            If_Body_Flattener = flatteningVisitor(self.tempCount)
            Body_Node = If_Body_Flattener.visit(node.body[i])
            nextElement = If_Body_Flattener.newBody
            for element in nextElement:
                newConditionalBody.append(element)
            self.tempCount = If_Body_Flattener.tempCount
        node.body = newConditionalBody

        for i in range(len(node.orelse)):
            If_Orelse_Flattener = flatteningVisitor(self.tempCount)
            Orelse_Node = If_Orelse_Flattener.visit(node.orelse[i])
            nextElement = If_Orelse_Flattener.newBody
            for element in nextElement:
                newConditionalOrelse.append(element)
            self.tempCount = If_Orelse_Flattener.tempCount
        node.orelse = newConditionalOrelse

        self.newBody.append(node)
        return node
        
    def visit_While(self, node):
        newLoopBody = []

        for i in range(len(node.body)):
            While_Flattener = flatteningVisitor(self.tempCount)
            While_Node = While_Flattener.visit(node.body[i])
            nextElement = While_Flattener.newBody
            for element in nextElement:
                newLoopBody.append(element)
            self.tempCount = While_Flattener.tempCount
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
            replacementNode = self.BooleanReplacement(node)
        
            return replacementNode
        return node
    
    def visit_IfExp(self, node):
        return node
    
    def visit_Dict(self, node):
        #call generic visit to implement depth first traversal of AST
        self.generic_visit(node)
    

        #check if left and right are complex aka. a constant value or a variable
        simpleInputs = True
        for i in node.keys:
            if not self.checkSimplicity(i):
                simpleInputs = False
        for i in node.values:
            if not self.checkSimplicity(i):
                simpleInputs = False
    
        if simpleInputs:
            if isinstance(node.parent, Assign):
                return node
            
            #create new temp node
            tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

            replacementNode = self.appendTemp(tempNode)
        
            return replacementNode
        return node
    
    def visit_List(self, node):
        #call generic visit to implement depth first traversal of AST
        self.generic_visit(node)
    

        #check if left and right are complex aka. a constant value or a variable
        simpleInputs = True
        for i in node.elts:
            if not self.checkSimplicity(i):
                simpleInputs = False
    
        if simpleInputs and (not isinstance(node.parent, UnaryOp)):
            if isinstance(node.parent, Assign):
                return node
            
            #create new temp node
            tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

            replacementNode = self.appendTemp(tempNode)
        
            return replacementNode
        return node
    
    def visit_Subscript(self, node):
        self.generic_visit(node)
        if (isinstance(node.ctx, Load)):
            if (self.checkSimplicity(node.value) and self.checkSimplicity(node.slice) and (not isinstance(node.parent, Assign))):
                tempNode = ast.Assign(targets=[ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())], value=node)

                replacementNode = self.appendTemp(tempNode)
            
                return replacementNode
        
        return node

    def visit_FunctionDef(self, node):
        newFunctionBody = []

        for i in range(len(node.body)):
            Function_Flattener = flatteningVisitor(self.tempCount)
            Function_Node = Function_Flattener.visit(node.body[i])
            nextElement = Function_Flattener.newBody
            for element in nextElement:
                newFunctionBody.append(element)
            self.tempCount = Function_Flattener.tempCount
        node.body = newFunctionBody

        self.newBody.append(node)
        return node
    
    def visit_Return(self, node):
        self.generic_visit(node)

        if isinstance(node.value, IfExp):
            if (not self.checkSimplicity(node.value.test)):
                expTest = self.visit(node.value.test)
            else:
                expTest = node.value.test
            
            expTarg = ast.Name(id=('t' + str(self.tempCount)), ctx=ast.Store())
            self.tempCount += 1

            bodyAssign = ast.Assign(
                targets=[expTarg], 
                value=node.value.body,
            )

            newTernaryBody = []
            ternaryFlattener = flatteningVisitor(self.tempCount)
            ternaryParentAdder = ParentAdder()
            ternaryParentAdder.visit(bodyAssign)
            Body_Node = ternaryFlattener.visit(bodyAssign)
            nextElement = ternaryFlattener.newBody
            for element in nextElement:
                newTernaryBody.append(element)
            self.tempCount = ternaryFlattener.tempCount

            elseAssign = ast.Assign(
                targets=[expTarg], 
                value=node.value.orelse,
            )
            
            newTernaryOrelse = []
            ternaryOrelseParentAdder = ParentAdder()
            ternaryOrelseParentAdder.visit(elseAssign)
            ternaryElseFlattener = flatteningVisitor(self.tempCount)
            Else_Node = ternaryElseFlattener.visit(elseAssign)
            nextElement = ternaryElseFlattener.newBody
            for element in nextElement:
                newTernaryOrelse.append(element)
            self.tempCount = ternaryElseFlattener.tempCount

            replacementNode = ast.If(
                test=expTest,
                body=newTernaryBody,
                orelse=newTernaryOrelse
            )

            self.newBody.append(replacementNode)

            node.value = expTarg

        self.newBody.append(node)
        return node

#---------------------------------------------------------------------------------------------------------------------

#class for adding parents to each node in tree
class ParentAdder(ast.NodeVisitor):
    def handle_Node(self,node):
        for child in ast.iter_child_nodes(node):
            child.parent = node
        self.generic_visit(node)
    def visit_Module(self, node):
        self.handle_Node(node)
    def visit_Expr(self, node):
        self.handle_Node(node)
    def visit_Assign(self, node):
        self.handle_Node(node)
    def visit_Constant(self, node):
        self.handle_Node(node)
    def visit_Name(self, node):
        self.handle_Node(node)
    def visit_BinOp(self, node):
        self.handle_Node(node)
    def visit_UnaryOp(self, node):
        self.handle_Node(node)
    def visit_Call(self, node):
        self.handle_Node(node)
    def visit_Add(self, node):
        self.handle_Node(node)
    def visit_USub(self, node):
        self.handle_Node(node)
    def visit_Store(self, node):
        self.handle_Node(node)
    def visit_Load(self, node):
        self.handle_Node(node)
    def visit_BoolOp(self, node):
        self.handle_Node(node)
    def visit_And(self, node):
        self.handle_Node(node)
    def visit_Or(self, node):
        self.handle_Node(node)
    def visit_Eq(self, node):
        self.handle_Node(node)
    def visit_NotEq(self, node):
        self.handle_Node(node)
    def visit_Not(self, node):
        self.handle_Node(node)
    def visit_While(self, node):
        self.handle_Node(node)
    def visit_If(self, node):
        self.handle_Node(node)
    def visit_Compare(self, node):
        self.handle_Node(node)
    def visit_IfExp(self, node):
        self.handle_Node(node)
    def visit_List(self, node):
        self.handle_Node(node)
    def visit_Dict(self, node):
        self.handle_Node(node)
    def visit_Subscript(self, node):
        self.handle_Node(node)
    def visit_FunctionDef(self, node):
        self.handle_Node(node)
    def visit_Lambda(self, node):
        self.handle_Node(node)
    def visit_Return(self, node):
        self.handle_Node(node)
    def __init__(self):
        self.count = 0