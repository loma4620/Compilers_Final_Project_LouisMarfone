import ast
from liveness import *
from InterferenceGraph import *
from flat import *
from desugar import *
from explicate import *

#IR Generator
class IRGenerator(ast.NodeVisitor):
    def __init__(self, ifCounter, whileCounter, tempCount=0):
        self.flattenedTempCount = tempCount
        self.prog = [] # array for storing commands
        self.variableCount = 0
        self.progVariables = [] 
        self.ifCounter = ifCounter
        self.whileCounter = whileCounter
        self.runtimeFunctions = ['get_free_vars', 'get_function', 'get_fun_ptr', 'is_int', 'is_bool', 'is_big', 'is_float', 'is_function', 'is_object', 'is_class', 'is_unbound_method', 'is_bound_method', 'inject_int', 'inject_bool', 'inject_float', 'inject_big', 'project_int', 'project_bool', 'project_float', 'project_big', 'project_function', 'project_class', 'project_object', 'project_bound_method', 'project_unbound_method', 'error_pyobj', 'print_any', 'eval_input', 'eval_input_pyobj', 'print_int_nl', 'create_list', 'is_true']
        self.multiParams = ['set_subscript', 'get_subscript', 'add', 'equal', 'not_equal', 'create_closure', 'set_free_vars']

    def reverseList(self, lst):
        idx = 0
        correctedlst = []

        elementLength = len(lst)
        for i in range(len(lst)):
            idx = elementLength - (i+1)
            correctedlst.append(lst[idx])
        
        return correctedlst

    def visit_Module(self, node):
        self.generic_visit(node)
    
    def visit_Assign(self, node): 
        targets = node.targets[0].id
        if isinstance(node.value, Constant):
            constant = node.value.value
            self.prog.insert(0, ['movl', constant, targets])
        
        if isinstance(node.value, Name):
            name = node.value.id
            self.prog.insert(0, ['movl', name, targets])

        if isinstance(node.value, BinOp):
            left_const = 0
            right_const = 0
            left_name = ''
            right_name = ''
            targ_left = False
            targ_right = False
            targ_both = False

            if isinstance(node.value.left, Constant):
                left_const = node.value.left.value
            else:
                left_name = node.value.left.id

            if isinstance(node.value.right, Constant):
                right_const = node.value.right.value
            else:
                right_name = node.value.right.id
            
            if (left_name == targets):
                targ_left = True
            if (right_name == targets):
                targ_right = True
            if (targ_left and targ_right):
                targ_both = True
            
            if (targ_left): # left name is a target
                if (right_name == ''):
                    self.prog.insert(0, ['addl', right_const, left_name])
                else: 
                    self.prog.insert(0, ['addl', right_name, left_name])
            elif(targ_right): # right name is a target
                if (left_name == ''):
                    self.prog.insert(0, ['addl', left_const, right_name])
                else:
                    self.prog.insert(0, ['addl', left_name, right_name])
            elif(targ_both): # both are targets
                self.prog.insert(0, ['addl', targets, targets])
            else: # neither is a target
                if (left_name == ''):
                    self.prog.insert(0, ['movl', left_const, targets])
                else:
                    self.prog.insert(0, ['movl', left_name, targets])
                
                if (right_name == ''):
                    self.prog.insert(0, ['addl', right_const, targets])
                else:
                    self.prog.insert(0, ['addl', right_name, targets])
        
        if isinstance(node.value, UnaryOp):
            operand_const = 0
            operand_name = ''

            if isinstance(node.value.operand, Constant):
                operand_const = node.value.operand.value
            else:
                operand_name = node.value.operand.id 
            # if we dont have an operand name, its a const
            if (operand_name == ''):
                self.prog.insert(0, ['movl', operand_const, targets])
            else:
                self.prog.insert(0, ['movl', operand_name, targets])
            
            self.prog.insert(0, ['negl', 'NULL', targets])
        
        if isinstance(node.value, Call):
            if (node.value.func.id == 'eval'):
                self.prog.insert(0, ['call', 'eval_input_pyobj', 'NULL', targets])
            # note: 4 arguments for call instead of 3
            elif (node.value.func.id in self.runtimeFunctions):
                arg_const = 0
                arg_name = ''

                if isinstance(node.value.args[0], Constant):
                    arg_const = node.value.args[0].value
                else:
                    arg_name = node.value.args[0].id

                if (arg_name == ''):
                    self.prog.insert(0, ['call', node.value.func.id, arg_const, targets])
                else:
                    self.prog.insert(0, ['call', node.value.func.id, arg_name, targets])
            elif (node.value.func.id == 'create_dict'):
                self.prog.insert(0, ['call', 'create_dict', 'NULL', targets])
            # in p0a, int() implies a compare or the "not" keyword operation
            elif (node.value.func.id == 'int'):
                if isinstance(node.value.args[0], UnaryOp):
                    if isinstance(node.value.args[0].operand, Constant):
                        operand = node.value.args[0].operand.value
                    else:
                        operand = node.value.args[0].operand.id
                    
                    self.prog.insert(0, ['not', operand, node.targets[0].id])

                elif isinstance(node.value.args[0], Compare):
                    if isinstance(node.value.args[0].left, Constant):
                        left = node.value.args[0].left.value
                    else:
                        left = node.value.args[0].left.id
                    if isinstance(node.value.args[0].comparators[0], Constant):
                        right = node.value.args[0].comparators[0].value
                    else:
                        right = node.value.args[0].comparators[0].id
                    if isinstance(node.value.args[0].ops[0], Eq):
                        self.prog.insert(0, ['equals', left, right, node.targets[0].id])
                    else:
                        self.prog.insert(0, ['nequals', left, right, node.targets[0].id])
            elif (len(node.value.args) >= 1):
                command = ['call', node.value.func.id]
                for arg in node.value.args:
                    if (isinstance(arg, Name)):
                        command.insert(2, arg.id)
                    else:
                        command.insert(2, arg.value)
                command.append(targets)
                self.prog.insert(0, command)
            
        
        if isinstance(node.value, Compare):
            if isinstance(node.value.left, Constant):
                left = node.value.left.value
            else:
                left = node.value.left.id

            if isinstance(node.value.comparators[0], Constant):
                right = node.value.comparators[0].value
            else:
                right = node.value.comparators[0].id

            if isinstance(node.value.ops[0], Eq):
                self.prog.insert(0, ['equals', left, right, node.targets[0].id])
            elif isinstance(node.value.ops[0], NotEq):
                self.prog.insert(0, ['nequals', left, right, node.targets[0].id])
            else:
                self.prog.insert(0, ['is', left, right, node.targets[0].id])
        self.generic_visit(node)
    
    def visit_Expr(self, node):
        if isinstance(node.value, Call):
            if (node.value.func.id in self.runtimeFunctions):
                arg_const = 0
                arg_name = ''

                if isinstance(node.value.args[0], Constant):
                    arg_const = node.value.args[0].value
                else:
                    arg_name = node.value.args[0].id
                
                if (arg_name == ''):
                    self.prog.insert(0, ['call', node.value.func.id, arg_const, 'NULL'])
                else:
                    self.prog.insert(0, ['call', node.value.func.id, arg_name, 'NULL'])
            
            if (node.value.func.id == 'eval'):
                # if parent is assign, we dealt with it in visit_Asssign
                if not isinstance(node.parent, Assign):
                    self.prog.insert(0, ['call', 'eval_input_pyobj', 'NULL', 'NULL'])

        self.generic_visit(node) 

    def visit_If(self, node):

        currIfCount = self.ifCounter
        self.ifCounter += 1
        self.whileCounter += 1

        if isinstance(node.test, Name):
            self.prog.insert(0, ['cmpl', 0, node.test.id])
        else:
            self.prog.insert(0, ['cmpl', 0, node.test.value])

        if (len(node.orelse) != 0):
            self.prog.insert(0, ['je', 'else', currIfCount])
        else:
            self.prog.insert(0, ['je', 'endif', currIfCount])
        self.prog.insert(0, ['LABEL'])
        self.prog.insert(0, ['then:', currIfCount])


        for i in range(len(node.body)):
            If_IR_Generator = IRGenerator(self.ifCounter, self.whileCounter, self.flattenedTempCount)
            Body_Node = If_IR_Generator.visit(node.body[i])
            self.ifCounter = If_IR_Generator.ifCounter
            self.whileCounter = If_IR_Generator.whileCounter

            nextElement = If_IR_Generator.prog
            nextElementCorrected = self.reverseList(nextElement)
            for element in nextElementCorrected:
                self.prog.insert(0, element)

        self.prog.insert(0, ['jmp', 'endif', currIfCount])
        if (len(node.orelse) != 0):
            self.prog.insert(0, ['LABEL'])
            self.prog.insert(0, ['else:', currIfCount])

            for i in range(len(node.orelse)):
                idx = 0
                correctedElement = []
                Orelse_IR_Generator = IRGenerator(self.ifCounter, self.whileCounter, self.flattenedTempCount)
                Orelse_Node = Orelse_IR_Generator.visit(node.orelse[i])
                self.ifCounter = Orelse_IR_Generator.ifCounter
                self.whileCounter = Orelse_IR_Generator.whileCounter

                nextElement = Orelse_IR_Generator.prog
                correctedElement = self.reverseList(nextElement)
                for element in correctedElement:
                    self.prog.insert(0, element)
            self.prog.insert(0, ['LABEL'])
        
        if (len(node.orelse) == 0):
            self.prog.insert(0, ['LABEL'])
        self.prog.insert(0, ['endif:', currIfCount])

    def visit_While(self, node):

        self.prog.insert(0, ['LABEL']) # create label for CFG

        currWhileCount = self.whileCounter
        self.ifCounter += 1
        self.whileCounter += 1

        self.prog.insert(0, ['while:', currWhileCount])

        #flatten while conditions ast
        conditionFlattener = flatteningVisitor(self.flattenedTempCount)
        conditionFlattener.visit(node.test)
        self.flattenedTempCount = conditionFlattener.tempCount

        #add parents to flattened while conditions ast for the explicator
        pa = ParentAdder()
        for x in conditionFlattener.newBody:
            pa.visit(x)

        #explicate while conditions ast
        conditionExplicator = explicateVisitor(self.flattenedTempCount)
        for currNode in conditionFlattener.newBody:
            conditionExplicator.visit(currNode)
        self.flattenedTempCount = conditionExplicator.tempCount  

        # add parents again for second flattening
        for x in conditionExplicator.newBody:
            pa.visit(x)

        # flatten explicated while conditions ast
        conditionFlattener2 = flatteningVisitor(self.flattenedTempCount)
        for currNode in conditionExplicator.newBody:
            conditionFlattener2.visit(currNode)
        self.flattenedTempCount = conditionFlattener.tempCount

        # Add parents for desugaring
        for x in conditionFlattener2.newBody:
            pa.visit(x)

        #desugar while conditions ast
        conditionDesugar = desugaringVisitor(self.flattenedTempCount)
        for currNode in conditionFlattener2.newBody:
            conditionDesugar.visit(currNode)
        self.flattenedTempCount = conditionDesugar.tempCount

        #generate IR for while conditions
        conditionBody = conditionDesugar.newBody
        for element in conditionBody:
            conditionIRGen = IRGenerator(self.ifCounter, self.whileCounter, self.flattenedTempCount)
            conditionIRGen.visit(element)
            self.ifCounter = conditionIRGen.ifCounter
            self.whileCounter = conditionIRGen.whileCounter

            reversedConditionIR = self.reverseList(conditionIRGen.prog)
            for i in reversedConditionIR:
                self.prog.insert(0, i)

        count = 0
        if (conditionFlattener.tempCount > 0):
            count = conditionFlattener.tempCount - 1
        else:
            count = conditionFlattener.tempCount

        self.prog.insert(0, ['cmpl', 0, 't'+ str(count)])
        self.prog.insert(0, ['je', 'end', currWhileCount])
        self.prog.insert(0, ['LABEL'])
        self.prog.insert(0, ['Loop:', currWhileCount])
        
        for i in range(len(node.body)):
            While_IR_Generator = IRGenerator(self.ifCounter, self.whileCounter, self.flattenedTempCount)
            While_Node = While_IR_Generator.visit(node.body[i])
            self.whileCounter = While_IR_Generator.whileCounter
            self.ifCounter = While_IR_Generator.ifCounter

            nextElement = While_IR_Generator.prog
            nextElementCorrected = self.reverseList(nextElement)
            for element in nextElementCorrected:
                self.prog.insert(0, element)


        self.prog.insert(0, ['jmp', 'while', currWhileCount])
        self.prog.insert(0, ['LABEL'])
        self.prog.insert(0, ['end:', currWhileCount])
    
    def visit_FunctionDef(self, node):
        defCommand = ['def', node.name]
        for i in node.args.args:
            defCommand.append(i.arg)
        self.prog.insert(0, defCommand)

        self.generic_visit(node)
    
    def visit_Return(self, node):
        if isinstance(node.value, Constant):
            self.prog.insert(0, ['ret', node.value.value])
        else:
            self.prog.insert(0, ['ret', node.value.id])

def RemakeIR(spilledVariables, IR_prog):
    runtimeFuncs = ['is_function', 'is_int', 'is_bool', 'is_big', 'is_float', 'is_function', 'is_object', 'is_class', 'is_unbound_method', 'is_bound_method', 'inject_int', 'inject_bool', 'inject_float', 'inject_big', 'project_int', 'project_bool', 'project_float', 'project_big', 'project_function', 'project_class', 'project_object', 'project_bound_method', 'project_unbound_method', 'error_pyobj', 'create_list', 'is_true', 'get_fun_ptr', 'get_free_vars']
    multiParams = ['set_subscript', 'get_subscript', 'add', 'equal', 'not_equal', 'set_free_vars']
    for var in spilledVariables:
        currentVariable = var
        index = 0
        while(index != len(IR_prog)):
            command = IR_prog[index]
            match command[0]:
                case 'movl':
                    if ((command[2] == currentVariable) and (command[1] in spilledVariables)):
                        replacements = [['movl', 'st1', command[2]], ['movl', command[1], 'st1']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        
                        IR_prog.remove(command)
                    else:
                        index += 1
                case 'addl':
                    if (command[2] == currentVariable):
                        replacements = [['movl', 'st2', command[2]], ['addl', 'st1', 'st2'], ['movl', command[2], 'st2'], ['movl', command[1], 'st1']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                            
                        IR_prog.remove(command)
                    else:
                        index += 1
                case 'negl':
                    if (command[2] == currentVariable):
                        replacements = [['movl', 'st1', command[2]], ['negl', 'NULL', 'st1'], ['movl', command[2], 'st1']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        IR_prog.remove(command)
                    else:
                        index += 1
                case 'call':
                    if ((command[3] == currentVariable) and (command[1] == 'eval_input_pyobj')):
                        replacements = [['movl', 'st1', command[3]], ['call', 'eval_input_pyobj', 'NULL', 'st1']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        IR_prog.remove(command)
                    elif ((command[3] == currentVariable) and (command[1] == 'print_any' or command[1] == 'create_dict')):
                        replacements = [['movl', 'st1', command[3]], ['call', command[1], 'NULL', 'st1']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        IR_prog.remove(command)
                    elif ((command[2] == currentVariable) and (command[1] == 'print_any')):
                        replacements = [['call', 'print_any', 'st1', 'NULL'], ['movl', command[2], 'st1']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        IR_prog.remove(command)
                    elif ((command[3] == currentVariable or command[2] == currentVariable) and (command[1] in runtimeFuncs)):
                        replacements = [['movl', 'st2', command[3]], ['call', command[1], 'st1', 'st2'], ['movl', command[2], 'st1']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        IR_prog.remove(command)
                    elif (command[1] in multiParams):
                        replace = False
                        for var in command[2:]:
                            if var == currentVariable:
                                replace = True

                        if (replace):
                            if (len(command) == 6):
                                replacements = [['movl', 'st4', command[5]], ['call', command[1], 'st1', 'st2', 'st3', 'st4'], ['movl', command[4], 'st3'], ['movl', command[3], 'st2'], ['movl', command[2], 'st1']]
                            else:
                                replacements = [['movl', 'st3', command[4]], ['call', command[1], 'st1', 'st2', 'st3'], ['movl', command[3], 'st2'], ['movl', command[2], 'st1']]
                            
                            for replacement in replacements:
                                IR_prog.insert(index, replacement)
                                index += 1
                            IR_prog.remove(command)
                        else:
                            index += 1
                    elif (command[1] == 'create_closure'):
                        replace = False
                        for var in [command[2], command[4]]:
                            if var == currentVariable:
                                replace = True
                        
                        if (replace):
                            replacements = [['movl', 'st2', command[4]], ['call', command[1], 'st1', command[3], 'st2'], ['movl', command[2], 'st1']]

                            for replacement in replacements:
                                IR_prog.insert(index, replacement)
                                index += 1
                            IR_prog.remove(command)
                        else:
                            index += 1
                    else:
                        index += 1
                case 'nequals':
                    if (command[1] == currentVariable) or (command[2] == currentVariable) or (command[3] == currentVariable):
                        replacements = [['movl', 'st2', command[3]], ['nequals', 'st4', 'st3', 'st2'], ['movl', command[1], 'st4'], ['movl', command[2], 'st3'], ['movl', command[3], 'st2']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        IR_prog.remove(command)
                    else:
                        index += 1
                case 'equals':
                    if (command[1] == currentVariable) or (command[2] == currentVariable) or (command[3] == currentVariable):
                        replacements = [['movl', 'st2', command[3]], ['equals', 'st4', 'st3', 'st2'], ['movl', command[1], 'st4'], ['movl', command[2], 'st3'], ['movl', command[3], 'st2']]
                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        
                        IR_prog.remove(command)
                    else:
                        index += 1
                case 'cmpl':
                    if (command[2] == currentVariable):

                        replacements = [['cmpl', 'st2', 'st1'], ['movl', command[1], 'st2'], ['movl', command[2], 'st1']]

                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        
                        IR_prog.remove(command)
                    else:
                        index += 1
                case 'ret':
                    if (command[1] == currentVariable):
                        replacements = [['ret', 'st1'], ['movl', command[1], 'st1']]

                        for replacement in replacements:
                            IR_prog.insert(index, replacement)
                            index += 1
                        
                        IR_prog.remove(command)
                    else:
                        index += 1
                case _:
                    index += 1
                
    return IR_prog