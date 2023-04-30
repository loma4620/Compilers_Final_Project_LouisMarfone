import sys
import ast
from ast import *

class explicateVisitor(ast.NodeTransformer):
    def __init__(self, currTemps=0):
        self.tempCount = currTemps
        self.tempProg = ''
        self.newBody = []
        self.pythonFuncs = ['print', 'int', 'eval', 'input', 'create_closure', 'set_free_vars']
        self.runtimeFunctions = ['error_pyobj', 'tag', 'is_int', 'is_bool', 'is_float', 'is_big', 'is_function', 'is_object', 'is_class', 'is_unbound_method', 'is_bound_method', 'inject_int', 'inject_bool', 'inject_float', 'inject_big', 'project_int', 'project_bool', 'project_float', 'project_big', 'project_function', 'project_class', 'project_object', 'project_bound_method', 'project_unbound_method']

    def visit_Module(self, node):
        self.generic_visit(node)
        node.body = self.newBody
    
    def visit_Name(self, node):
        return node
    
    def visit_Constant(self, node):
        return node
    
    def visit_Assign(self, node):
        if (isinstance(node.targets[0], Name)):
            targ = node.targets[0].id
        
        if isinstance(node.value, BinOp):
            if (isinstance(node.value.left, Constant)):
                if (type(node.value.left.value) == int):
                    leftOp = 'inject_int(' + str(node.value.left.value) + ')'
                    leftTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += leftTemp + ' = ' + leftOp + '\n'
                else:
                    leftOp = 'inject_bool(' + str(node.value.left.value) + ')'
                    leftTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += leftTemp + ' = ' + leftOp + '\n'
            else:
                leftTemp = node.value.left.id
            
            if (isinstance(node.value.right, Constant)):
                if (type(node.value.right.value) == int):
                    rightOp = 'inject_int(' + str(node.value.right.value) + ')'
                    rightTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += rightTemp + ' = ' + rightOp + '\n'
                else:
                    rightOp = 'inject_bool(' + str(node.value.right.value) + ')'
                    rightTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += rightTemp + ' = ' + rightOp + '\n'
            else:
                rightTemp = node.value.right.id

            self.tempProg += 'if (is_int(' + leftTemp + ')):\n' #left side of binop is int
            self.tempProg += '  if (is_int(' + rightTemp + ')):\n' #right is int
            self.tempProg += '      ' + targ + ' = inject_int(project_int(' + leftTemp + ') + project_int(' + rightTemp + '))\n'
            self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
            self.tempProg += '      ' + targ + ' = error_pyobj(0) \n'
            self.tempProg += '  else:\n' # right is bool
            self.tempProg += '      ' + targ + ' = inject_int(project_int(' + leftTemp + ') + project_bool(' + rightTemp + '))\n'
            self.tempProg += 'elif (is_bool(' + leftTemp + ')):\n'
            self.tempProg += '  if (is_bool(' + rightTemp + ')):\n'
            self.tempProg += '      ' + targ + ' = inject_int(project_bool(' + leftTemp + ') + project_bool(' + rightTemp + '))\n'
            self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
            self.tempProg += '      ' + targ + ' = error_pyobj(0) \n'
            self.tempProg += '  else:\n' # right is int
            self.tempProg += '      ' + targ + ' = inject_int(project_bool(' + leftTemp + ') + project_int(' + rightTemp + '))\n'
            self.tempProg += 'elif (is_big(' + leftTemp + ')):\n'
            self.tempProg += '  if (is_big(' + rightTemp + ')):\n'
            self.tempProg += '      ' + targ + ' = inject_big(add(project_big(' + leftTemp + '), project_big(' + rightTemp + ')))\n'
            self.tempProg += '  else:\n'
            self.tempProg += '      ' + targ + ' = error_pyobj(0)'

            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = ''
        elif isinstance(node.value, BoolOp):
            if (isinstance(node.value.values[0], Constant)):
                if (type(node.value.values[0].value) == int):
                    leftOp = 'inject_int(' + str(node.value.values[0].value) + ')'
                    leftTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += leftTemp + ' = ' + leftOp + '\n'
                else:
                    leftOp = 'inject_bool(' + str(node.value.values[0].value) + ')'
                    leftTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += leftTemp + ' = ' + leftOp + '\n'
            elif (isinstance(node.value.values[1], List) or isinstance(node.value.values[0], Dict)):
                leftOp = 'inject_big(' + str(node.value.values[0]) + ')'
                leftTemp = 't' + str(self.tempCount)
                self.tempCount += 1
                self.tempProg += leftTemp + ' = ' + leftOp + '\n'
            else:
                leftTemp = node.value.values[0].id
            
            if (isinstance(node.value.values[1], Constant)):
                if (type(node.value.values[1].value) == int):
                    rightOp = 'inject_int(' + str(node.value.values[1].value) + ')'
                    rightTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += rightTemp + ' = ' + rightOp + '\n'
                else:
                    rightOp = 'inject_bool(' + str(node.value.values[1].value) + ')'
                    rightTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += rightTemp + ' = ' + rightOp + '\n'
            else:
                rightTemp = node.value.values[1].id    

            op = node.value.op
            if isinstance(op, And):
                self.tempProg += 'if (not(is_true(' + leftTemp + '))):\n'
                self.tempProg += '  ' + targ + ' = ' + leftTemp + '\n'
                self.tempProg += 'else:\n'
                self.tempProg += '  ' + targ + ' = ' + rightTemp + '\n'
            else:
                self.tempProg += 'if (is_true(' + leftTemp + ')):\n'
                self.tempProg += '  ' + targ + ' = ' + leftTemp + '\n'
                self.tempProg += 'else:\n'
                self.tempProg += '  ' + targ + ' = ' + rightTemp + '\n' 

            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = '' 
        elif isinstance(node.value, UnaryOp):
            if isinstance(node.value.op, USub):
                if (isinstance(node.value.operand, Constant)):
                    operand = 'inject_int(' + str(node.value.operand.value) + ')'
                    operandTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += operandTemp + ' = ' + operand + '\n'
                else:
                    operandTemp = node.value.operand.id

                self.tempProg += 'if (is_int(' + operandTemp + ')):\n' #opeand is int
                self.tempProg += '  ' + targ + ' = inject_int(-project_int(' + operandTemp + '))\n'
                self.tempProg += 'elif (is_big(' + operandTemp + ')): \n' #operand is big
                self.tempProg += '  ' + targ + ' = error_pyobj(0) \n'
                self.tempProg += 'else:\n' # operand is bool
                self.tempProg += '  ' + targ + ' = inject_int(-project_bool(' + operandTemp + '))\n'
                
                tempTree = ast.parse(self.tempProg)

                for n in tempTree.body:
                    self.newBody.append(n)
                self.tempProg = ''
            elif isinstance(node.value.op, Not):
                if isinstance(node.value.operand, List):
                    lstLen = len(node.value.operand.elts)
                    listTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    target = node.targets[0].id

                    for i, val in enumerate(node.value.operand.elts):
                        if (isinstance(val, Constant)):
                            if (type(val.value) == int):
                                val = 'inject_int(' + str(node.value.operand.elts[i].value) + ')'
                                valTemp = 't' + str(self.tempCount)
                                self.tempCount += 1
                                self.tempProg += valTemp + ' = ' + val + '\n'
                                node.value.operand.elts[i] = ast.Name(id=valTemp, ctx=Load())
                            else:
                                val = 'inject_bool(' + str(node.value.operand.elts[i].value) + ')'
                                valTemp = 't' + str(self.tempCount)
                                self.tempCount += 1
                                self.tempProg += valTemp + ' = ' + val + '\n'
                                node.value.operand.elts[i] = ast.Name(id=valTemp, ctx=Load())
                    
                    assignIndex = 0
                    assignTemp = 't' + str(self.tempCount)
                    self.tempCount += 1

                    self.tempProg += listTemp + ' = inject_big(create_list(inject_int(' + str(lstLen) + ')))\n'
                    while (assignIndex != lstLen):
                        self.tempProg += assignTemp + ' = inject_int(' + str(assignIndex) + ')\n'
                        self.tempProg += assignTemp + ' = set_subscript(' + listTemp + ', ' + assignTemp + ', ' + node.value.operand.elts[assignIndex].id + ')\n'
                        assignIndex += 1
                    
                    self.tempProg += 'if (is_true(' + listTemp + ')):\n'
                    self.tempProg += '  ' + target + ' = inject_bool(0)\n'
                    self.tempProg += 'else:\n'
                    self.tempProg += '  ' + target + ' = inject_bool(1)\n'

                    tempTree = ast.parse(self.tempProg)

                    for n in tempTree.body:
                        self.newBody.append(n)
                    self.tempProg = ''
                elif isinstance(node.value.operand, Dict):
                    dictLen = len(node.value.operand.keys)
                    dictTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    target = node.targets[0].id

                    for i, key in enumerate(node.value.operand.keys):
                        if (isinstance(key, Constant)):
                            if (type(key.value) == int):
                                key = 'inject_int(' + str(node.value.operand.keys[i].value) + ')'
                                keyTemp = 't' + str(self.tempCount)
                                self.tempCount += 1
                                self.tempProg += keyTemp + ' = ' + key + '\n'
                                node.value.operand.keys[i] = ast.Name(id=keyTemp, ctx=Load())
                            else:
                                key = 'inject_bool(' + str(node.value.operand.keys[i].value) + ')'
                                keyTemp = 't' + str(self.tempCount)
                                self.tempCount += 1
                                self.tempProg += keyTemp + ' = ' + key + '\n'
                                node.value.operand.keys[i] = ast.Name(id=keyTemp, ctx=Load())

                    for j, val in enumerate(node.value.values):
                        if (isinstance(val, Constant)):
                            if (type(val.value) == int):
                                val = 'inject_int(' + str(node.value.values[j].value) + ')'
                                valTemp = 't' + str(self.tempCount)
                                self.tempCount += 1
                                self.tempProg += valTemp + ' = ' + val + '\n'
                                node.value.values[j] = ast.Name(id=valTemp, ctx=Load())
                            else:
                                val = 'inject_bool(' + str(node.value.values[j].value) + ')'
                                valTemp = 't' + str(self.tempCount)
                                self.tempCount += 1
                                self.tempProg += valTemp + ' = ' + val + '\n'
                                node.value.values[j] = ast.Name(id=valTemp, ctx=Load())

                    assignIndex = 0
                    assignTemp = 't' + str(self.tempCount)
                    self.tempCount += 1

                    self.tempProg += dictTemp + ' = inject_big(create_dict())\n'
                    while (assignIndex != dictLen):
                        self.tempProg += assignTemp + ' = set_subscript(' + dictTemp + ', ' + node.value.operand.keys[assignIndex].id + ', ' + node.value.values[assignIndex].id + ')\n'
                        assignIndex += 1

                    self.tempProg += 'if (is_true(' + dictTemp + ')):\n'
                    self.tempProg += '  ' + target + ' = inject_bool(0)\n'
                    self.tempProg += 'else:\n'
                    self.tempProg += '  ' + target + ' = inject_bool(1)\n'

                    tempTree = ast.parse(self.tempProg)

                    for n in tempTree.body:
                        self.newBody.append(n)
                    self.tempProg = ''

        elif isinstance(node.value, Compare):
            if (isinstance(node.value.left, Constant)):
                if (type(node.value.left.value) == int):
                    leftOp = 'inject_int(' + str(node.value.left.value) + ')'
                    leftTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += leftTemp + ' = ' + leftOp + '\n'
                else:
                    leftOp = 'inject_bool(' + str(node.value.left.value) + ')'
                    leftTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += leftTemp + ' = ' + leftOp + '\n'
            else:
                leftTemp = node.value.left.id
            
            if (isinstance(node.value.comparators[0], Constant)):
                if (type(node.value.comparators[0].value) == int):
                    rightOp = 'inject_int(' + str(node.value.comparators[0].value) + ')'
                    rightTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += rightTemp + ' = ' + rightOp + '\n'
                else:
                    rightOp = 'inject_bool(' + str(node.value.comparators[0].value) + ')'
                    rightTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += rightTemp + ' = ' + rightOp + '\n'
            else:
                rightTemp = node.value.comparators[0].id
            
            if isinstance(node.value.ops[0], NotEq):
                operator = '!='
                self.tempProg += 'if (is_int(' + leftTemp + ')):\n' #left side of binop is int
                self.tempProg += '  if (is_int(' + rightTemp + ')):\n' #right is int
                self.tempProg += '      ' + targ + ' = inject_bool(project_int(' + leftTemp + ') ' + operator + ' project_int(' + rightTemp + '))\n'
                self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
                self.tempProg += '      ' + targ + ' = inject_bool(0)\n'
                self.tempProg += '  else:\n' # right is bool
                self.tempProg += '      ' + targ + ' = inject_bool(project_int(' + leftTemp + ') ' + operator + ' project_bool(' + rightTemp + '))\n'
                self.tempProg += 'elif (is_bool(' + leftTemp + ')):\n' #left side of compare is bool
                self.tempProg += '  if (is_bool(' + rightTemp + ')):\n' #right is bool
                self.tempProg += '      ' + targ + ' = inject_bool(project_bool(' + leftTemp + ') ' + operator + ' project_bool(' + rightTemp + '))\n'
                self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
                self.tempProg += '      ' + targ + ' = inject_bool(0) \n'
                self.tempProg += '  else:\n' # right is int
                self.tempProg += '      ' + targ + ' = inject_bool(project_bool(' + leftTemp + ') ' + operator + ' project_int(' + rightTemp + '))\n'
                self.tempProg += 'elif (is_big(' + leftTemp + ')):\n' #left side of compare is big
                self.tempProg += '  if (is_big(' + rightTemp + ')):\n' #right is big
                self.tempProg += '      ' + targ + ' = inject_bool(not_equal(project_big(' + leftTemp + '), project_big(' + rightTemp + ')))\n'
                self.tempProg += '  elif (is_bool(' + rightTemp + ')): \n' #right is bool
                self.tempProg += '      ' + targ + ' = inject_bool(0) \n'
                self.tempProg += '  else:\n' # right is int
                self.tempProg += '      ' + targ + ' = inject_bool(0)\n'
            elif isinstance(node.value.ops[0], Eq):
                operator = '=='
                self.tempProg += 'if (is_int(' + leftTemp + ')):\n' #left side of binop is int
                self.tempProg += '  if (is_int(' + rightTemp + ')):\n' #right is int
                self.tempProg += '      ' + targ + ' = inject_bool(project_int(' + leftTemp + ') ' + operator + ' project_int(' + rightTemp + '))\n'
                self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
                self.tempProg += '      ' + targ + ' = inject_bool(0) \n'
                self.tempProg += '  else:\n' # right is bool
                self.tempProg += '      ' + targ + ' = inject_bool(project_int(' + leftTemp + ') ' + operator + ' project_bool(' + rightTemp + '))\n'
                self.tempProg += 'elif (is_bool(' + leftTemp + ')):\n' #left side of compare is bool
                self.tempProg += '  if (is_bool(' + rightTemp + ')):\n' #right is bool
                self.tempProg += '      ' + targ + ' = inject_bool(project_bool(' + leftTemp + ') ' + operator + ' project_bool(' + rightTemp + '))\n'
                self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
                self.tempProg += '      ' + targ + ' = inject_bool(0) \n'
                self.tempProg += '  else:\n' # right is int
                self.tempProg += '      ' + targ + ' = inject_bool(project_bool(' + leftTemp + ') ' + operator + ' project_int(' + rightTemp + '))\n'
                self.tempProg += 'elif (is_big(' + leftTemp + ')):\n' #left side of compare is big
                self.tempProg += '  if (is_big(' + rightTemp + ')):\n' #right is big
                self.tempProg += '      ' + targ + ' = inject_bool(equal(project_big(' + leftTemp + '), project_big(' + rightTemp + ')))\n'
                self.tempProg += '  elif (is_bool(' + rightTemp + ')): \n' #right is bool
                self.tempProg += '      ' + targ + ' = inject_bool(0) \n'
                self.tempProg += '  else:\n' # right is int
                self.tempProg += '      ' + targ + ' = inject_bool(0)\n'
            elif isinstance(node.value.ops[0], Is):
                operator = 'is'
                self.tempProg += targ + ' = inject_bool(' + leftTemp + ' == ' + rightTemp + ')'
            
            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = ''
        elif isinstance(node.value, Call):
            if (not((node.value.func.id in self.runtimeFunctions) and (node.value.func.id in self.functions))):
                if (node.value.func.id[0] == 't'):
                    # print(ast.dump(node, indent=4))
                    if (isinstance(node.value.args[0], Constant)) or (isinstance(node.value.args[0], Name) and node.value.args[0].id[0] != 't'):
                        ptrTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        freeVarsTemp = 't' + str(self.tempCount)
                        self.tempCount += 1

                        getPtrNode = ast.Assign(
                            targets=[ast.Name(id=ptrTemp, ctx=Store())],
                            value=ast.Call(
                                func=ast.Name(id='get_fun_ptr', ctx=Load()),
                                args=[ast.Name(id=node.value.func.id, ctx=Load())],
                                keywords=[]
                            )
                        )
                        self.newBody.append(getPtrNode)

                        getFreesNode = ast.Assign(
                            targets=[ast.Name(id=freeVarsTemp, ctx=Store())],
                            value=ast.Call(
                                func=ast.Name(id='get_free_vars', ctx=Load()),
                                args=[ast.Name(id=node.value.func.id, ctx=Load())],
                                keywords=[]
                            )
                        )
                        self.newBody.append(getFreesNode)

                        arguments = []
                        for arg in node.value.args:
                            if isinstance(arg, Constant):
                                injectTemp = 't' + str(self.tempCount)
                                self.tempCount += 1

                                if (type(arg.value) == int):
                                    injectFuncName = 'inject_int'
                                else:
                                    injectFuncName = 'inject_bool'

                                injectNode = ast.Call(
                                    func=ast.Name(id=injectFuncName, ctx=Load()),
                                    args=[arg],
                                    keywords=[]
                                )
                                arguments.append(injectNode)
                            else:
                                arguments.append(arg)

                        arguments.insert(0, ast.Name(id=freeVarsTemp, ctx=Load()))
                        
                        replacementNode = ast.Assign(
                            targets=[node.targets[0]],
                            value=ast.Call(
                                func=ast.Name(id=ptrTemp, ctx=Load()),
                                args=arguments, 
                                keywords=[]
                            )
                        )
                        self.newBody.append(replacementNode)
                        return node

            for i, arg in enumerate(node.value.args):
                if (isinstance(arg, Constant)):
                    if (type(arg.value) == int):
                        funcName = 'inject_int'
                    else:
                        funcName = 'inject_bool'
                    
                    replacementNode = ast.Call(
                        func=ast.Name(id=funcName, ctx=Load()),
                        args=[arg],
                        keywords=[]
                    )
                    node.value.args.remove(arg)
                    node.value.args.insert(i, replacementNode)

            if (node.value.func.id == 'int'):
                if isinstance(node.value.args[0], Compare):
                    if (isinstance(node.value.args[0].left, Constant)):
                        if (type(node.value.args[0].left.value) == int):
                            leftOp = 'inject_int(' + str(node.value.args[0].left.value) + ')'
                            leftTemp = 't' + str(self.tempCount)
                            self.tempCount += 1
                            self.tempProg += leftTemp + ' = ' + leftOp + '\n'
                        else:
                            leftOp = 'inject_bool(' + str(node.value.args[0].left.value) + ')'
                            leftTemp = 't' + str(self.tempCount)
                            self.tempCount += 1
                            self.tempProg += leftTemp + ' = ' + leftOp + '\n'
                    else:
                        leftTemp = node.value.args[0].left.id
                    
                    if (isinstance(node.value.args[0].comparators[0], Constant)):
                        if (type(node.value.args[0].comparators[0].value) == int):
                            rightOp = 'inject_int(' + str(node.value.args[0].comparators[0].value) + ')'
                            rightTemp = 't' + str(self.tempCount)
                            self.tempCount += 1
                            self.tempProg += rightTemp + ' = ' + rightOp + '\n'
                        else:
                            rightOp = 'inject_bool(' + str(node.value.args[0].comparators[0].value) + ')'
                            rightTemp = 't' + str(self.tempCount)
                            self.tempCount += 1
                            self.tempProg += rightTemp + ' = ' + rightOp + '\n'
                    else:
                        rightTemp = node.value.args[0].comparators[0].id
                    
                    if isinstance(node.value.args[0].ops[0], NotEq):
                        operator = '!='
                    elif isinstance(node.value.args[0].ops[0], Eq):
                        operator = '=='
                    elif isinstance(node.value.args[0].ops[0], Is):
                        operator = 'is'
                    
                    self.tempProg += 'if (is_int(' + leftTemp + ')):\n' #left side of binop is int
                    self.tempProg += '  if (is_int(' + rightTemp + ')):\n' #right is int
                    self.tempProg += '      ' + targ + ' = inject_int(project_int(' + leftTemp + ') ' + operator + ' project_int(' + rightTemp + '))\n'
                    self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
                    self.tempProg += '      ' + targ + ' = inject_int(0) \n'
                    self.tempProg += '  else:\n' # right is bool
                    self.tempProg += '      ' + targ + ' = inject_int(project_int(' + leftTemp + ') ' + operator + ' project_bool(' + rightTemp + '))\n'
                    self.tempProg += 'elif (is_bool(' + leftTemp + ')):\n' #left side of compare is bool
                    self.tempProg += '  if (is_bool(' + rightTemp + ')):\n' #right is bool
                    self.tempProg += '      ' + targ + ' = inject_int(project_bool(' + leftTemp + ') ' + operator + ' project_bool(' + rightTemp + '))\n'
                    self.tempProg += '  elif (is_big(' + rightTemp + ')): \n' #right is big
                    self.tempProg += '      ' + targ + ' = inject_int(0) \n'
                    self.tempProg += '  else:\n' # right is int
                    self.tempProg += '      ' + targ + ' = inject_int(project_bool(' + leftTemp + ') ' + operator + ' project_int(' + rightTemp + '))\n'

                    tempTree = ast.parse(self.tempProg)

                    for n in tempTree.body:
                        self.newBody.append(n)
                    self.tempProg = ''
            elif(node.value.func.id == 'create_closure'):
                newNode = ast.Assign(
                    targets=[ast.Name(id=targ, ctx=Store())],
                    value=ast.Call(
                        func=ast.Name(id='inject_big', ctx=Load()),
                        args=[node.value],
                        keywords=[]
                    )
                )
                self.newBody.append(newNode)
            elif (node.value.func.id == 'set_free_vars'):
                funcVariable = node.value.args[0]
                tempHolder = 't' + str(self.tempCount)
                self.tempCount += 1

                projectNode = ast.Assign(
                    targets=[ast.Name(id=tempHolder, ctx=Store())],
                    value = ast.Call(
                        func=ast.Name(id='project_big', ctx=Load()),
                        args=[funcVariable],
                        keywords=[]
                    )
                )
                self.newBody.append(projectNode)

                tempNode = ast.Name(id=tempHolder, ctx=Store())

                node.value.args.pop(0)
                node.value.args.insert(0, tempNode)

                newNode = ast.Assign(
                    targets=[ast.Name(id=targ, ctx=Store())],
                    value = ast.Call(
                        func=ast.Name(id='inject_big', ctx=Load()),
                        args=[node.value],
                        keywords=[]
                    )
                )
                self.newBody.append(newNode)
            else:
                self.newBody.append(node)
        elif isinstance(node.value, Constant):
            operand = node.value.value
            target = node.targets[0]
            if (type(operand) == int):
                replacement = ast.Assign(
                                        targets=[target], 
                                        value=ast.Call(
                                            func=ast.Name(id='inject_int', ctx=ast.Load()), 
                                            args=[ast.Constant(value=operand)], 
                                            keywords=[]))
            else:
                replacement = ast.Assign(
                                        targets=[target], 
                                        value=ast.Call(
                                            func=ast.Name(id='inject_bool', ctx=ast.Load()), 
                                            args=[ast.Constant(value=operand)], 
                                            keywords=[]))

            self.newBody.append(replacement)
        elif isinstance(node.value, Dict):
            dictLen = len(node.value.keys)
            target = node.targets[0].id

            for i, key in enumerate(node.value.keys):
                if (isinstance(key, Constant)):
                    if (type(key.value) == int):
                        key = 'inject_int(' + str(node.value.keys[i].value) + ')'
                        keyTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += keyTemp + ' = ' + key + '\n'
                        node.value.keys[i] = ast.Name(id=keyTemp, ctx=Load())
                    else:
                        key = 'inject_bool(' + str(node.value.keys[i].value) + ')'
                        keyTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += keyTemp + ' = ' + key + '\n'
                        node.value.keys[i] = ast.Name(id=keyTemp, ctx=Load())

            for j, val in enumerate(node.value.values):
                if (isinstance(val, Constant)):
                    if (type(val.value) == int):
                        val = 'inject_int(' + str(node.value.values[j].value) + ')'
                        valTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += valTemp + ' = ' + val + '\n'
                        node.value.values[j] = ast.Name(id=valTemp, ctx=Load())
                    else:
                        val = 'inject_bool(' + str(node.value.values[j].value) + ')'
                        valTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += valTemp + ' = ' + val + '\n'
                        node.value.values[j] = ast.Name(id=valTemp, ctx=Load())

            assignIndex = 0
            assignTemp = 't' + str(self.tempCount)
            self.tempCount += 1

            self.tempProg += target + ' = inject_big(create_dict())\n'
            while (assignIndex != dictLen):
                self.tempProg += assignTemp + ' = set_subscript(' + target + ', ' + node.value.keys[assignIndex].id + ', ' + node.value.values[assignIndex].id + ')\n'
                assignIndex += 1

            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = ''
        elif isinstance(node.value, List):
            lstLen = len(node.value.elts)
            target = node.targets[0].id

            for i, val in enumerate(node.value.elts):
                if (isinstance(val, Constant)):
                    if (type(val.value) == int):
                        val = 'inject_int(' + str(node.value.elts[i].value) + ')'
                        valTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += valTemp + ' = ' + val + '\n'
                        node.value.elts[i] = ast.Name(id=valTemp, ctx=Load())
                    else:
                        val = 'inject_bool(' + str(node.value.elts[i].value) + ')'
                        valTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += valTemp + ' = ' + val + '\n'
                        node.value.elts[i] = ast.Name(id=valTemp, ctx=Load())
            
            assignIndex = 0
            assignTemp = 't' + str(self.tempCount)
            self.tempCount += 1

            self.tempProg += target + ' = inject_big(create_list(inject_int(' + str(lstLen) + ')))\n'
            while (assignIndex != lstLen):
                self.tempProg += assignTemp + ' = inject_int(' + str(assignIndex) + ')\n'
                self.tempProg += assignTemp + ' = set_subscript(' + target + ', ' + assignTemp + ', ' + node.value.elts[assignIndex].id + ')\n'
                assignIndex += 1

            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = ''
        elif isinstance(node.value, Subscript):
            if (isinstance(node.value.slice, Constant)):
                    if (type(node.value.slice.value) == int):
                        index = 'inject_int(' + str(node.value.slice.value) + ')'
                        indexTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += indexTemp + ' = ' + index + '\n'
                    else:
                        index = 'inject_bool(' + str(node.value.slice.value) + ')'
                        indexTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += indexTemp + ' = ' + index + '\n'
            else:
                indexTemp = node.value.slice.id


            target = node.targets[0].id
            structure = node.value.value.id

            self.tempProg += target + ' = get_subscript(' + structure + ', ' + indexTemp + ')\n' 

            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = ''
        elif isinstance(node.targets[0], Subscript):
            if (isinstance(node.value, Constant)):
                    if (type(node.value.value) == int):
                        value = 'inject_int(' + str(node.value.value) + ')'
                        valueTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += valueTemp + ' = ' + value + '\n'
                    else:
                        value = 'inject_bool(' + str(node.value.value) + ')'
                        valueTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += valueTemp + ' = ' + value + '\n'
            else:
                valueTemp = node.value.id
                
            if (isinstance(node.targets[0].slice, Constant)):
                    if (type(node.targets[0].slice.value) == int):
                        index = 'inject_int(' + str(node.targets[0].slice.value) + ')'
                        indexTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += indexTemp + ' = ' + index + '\n'
                    else:
                        index = 'inject_bool(' + str(node.targets[0].slice.value) + ')'
                        indexTemp = 't' + str(self.tempCount)
                        self.tempCount += 1
                        self.tempProg += indexTemp + ' = ' + index + '\n'
            else:
                indexTemp = node.targets[0].slice.id

            structure = node.targets[0].value.id
            assignTemp = 't' + str(self.tempCount)
            self.tempCount += 1

            self.tempProg += assignTemp + ' = set_subscript(' + structure + ', ' + indexTemp + ', ' + valueTemp + ')\n' 

            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = ''
        else:
            self.newBody.append(node)
    
        return node

    def visit_Expr(self, node):
        self.generic_visit(node)
        return node
    
    def visit_Return(self, node):
        self.generic_visit(node)
        if (isinstance(node.value, Constant)):
            if (type(node.value.value) == int):
                funcName = 'inject_int'
            else:
                funcName = 'inject_bool'
            replacementNode = ast.Call(
                func=ast.Name(id=funcName, ctx=Load()),
                args=[node.value],
                keywords=[]
            )
            node.value = replacementNode

            self.newBody.append(node)
        elif (isinstance(node.value, Name)):
            self.newBody.append(node)

        return node

    def visit_Call(self, node):
        if (node.func.id == 'print'):
            if isinstance(node.args[0], Constant):
                if (type(node.args[0].value == int)):
                    operand = 'inject_int(' + str(node.args[0].value) + ')'
                    operandTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += operandTemp + ' = ' + operand + '\n'
                elif (type(node.args[0].value == bool)):
                    operand = 'inject_bool(' + str(node.args[0].value) + ')'
                    operandTemp = 't' + str(self.tempCount)
                    self.tempCount += 1
                    self.tempProg += operandTemp + ' = ' + operand + '\n'
            else:
                operandTemp = node.args[0].id

            if isinstance(node.parent, Assign):
                targ = node.parent.targets[0]
                self.tempProg += targ + ' = print_any(' + operandTemp + '))\n'
            else:
                self.tempProg += 'print_any(' + operandTemp + ')'

            tempTree = ast.parse(self.tempProg)

            for n in tempTree.body:
                self.newBody.append(n)
            self.tempProg = ''

        return node

    def visit_If(self, node):
        newConditionalBody = []
        newConditionalOrelse = []
        newTest = self.visit(node.test)
        testTemp = 't' + str(self.tempCount)
        self.tempCount += 1
        self.tempProg += testTemp + ' = is_true(' + newTest.id + ')\n'

        tempTree = ast.parse(self.tempProg)

        for n in tempTree.body:
            self.newBody.append(n)
        self.tempProg = ''

        node.test = ast.Name(id=testTemp, ctx=Load())

        for i in range(len(node.body)):
            If_Body_Explicator = explicateVisitor(self.tempCount)
            Body_Node = If_Body_Explicator.visit(node.body[i])
            nextElement = If_Body_Explicator.newBody
            for element in nextElement:
                newConditionalBody.append(element)
            self.tempCount = If_Body_Explicator.tempCount
        node.body = newConditionalBody

        for i in range(len(node.orelse)):
            If_Orelse_Explicator = explicateVisitor(self.tempCount)
            Orelse_Node = If_Orelse_Explicator.visit(node.orelse[i])
            nextElement = If_Orelse_Explicator.newBody
            for element in nextElement:
                newConditionalOrelse.append(element)
            self.tempCount = If_Orelse_Explicator.tempCount
        node.orelse = newConditionalOrelse

        self.newBody.append(node)
        return node

    def visit_While(self, node):
        newLoopBody = []

        for i in range(len(node.body)):
            While_Explicator = explicateVisitor(self.tempCount)
            While_Node = While_Explicator.visit(node.body[i])
            nextElement = While_Explicator.newBody
            for element in nextElement:
                newLoopBody.append(element)
            self.tempCount = While_Explicator.tempCount
        node.body = newLoopBody

        self.newBody.append(node)
        return node

    def visit_FunctionDef(self, node):
        newFunctionBody = []

        for i in range(len(node.body)):
            Function_Explicator = explicateVisitor(self.tempCount)
            Func_Node = Function_Explicator.visit(node.body[i])
            nextElement = Function_Explicator.newBody
            for element in nextElement:
                newFunctionBody.append(element)
            self.tempCount = Function_Explicator.tempCount
        node.body = newFunctionBody

        self.newBody.append(node)
        return node
    
