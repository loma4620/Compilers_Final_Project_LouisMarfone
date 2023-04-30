import ast
from parse import * # overrides stdlib parser
from IR import *

#-----------------------------------------------------------------------------------------------------------------

#Variable Counter
class variableCounterTree(ast.NodeVisitor):
    def __init__(self):
        self.count = 0
        self.functions = ['print', 'input', 'eval']
        self.varNames = []
        
    def checkNameId(self, node):
        for i in self.functions:
            if (node.id == i):
                return True 
        return False 
    
    def alreadyFound(self, node):
        for i in self.varNames:
            if (node.id == i):
                return True
        return False
    
    def visit_Name(self, node):
        if not self.checkNameId(node):
            if not self.alreadyFound(node):
                
                self.varNames.append(node.id)
                self.count += 1
        self.generic_visit(node)
        
        
#------------------------------------------------------------------------------------------------------------------

def variableCounterIR(IR_prog):
    nonVariables = ['while', 'else', 'NULL', 'end', 'endif']
    variables = []
    for command in IR_prog:
        if (command[0] == 'def'):
            for i in range(2, len(command)):
                if ((type(command[2]) == str) and (command[2] not in nonVariables) and (command[2] not in variables)):
                    variables.insert(0, command[i])
        elif(len(command) == 2):
            if ((type(command[1]) == str) and (command[1] not in nonVariables) and (command[1] not in variables)):
                variables.insert(0, command[1])
        elif (len(command) == 3):
            if ((type(command[2]) == str) and (command[2] not in nonVariables) and (command[2] not in variables)):
                variables.insert(0, command[2])
            
            if ((type(command[1]) == str) and (command[1] not in nonVariables) and (command[1] not in variables)):
                variables.insert(0, command[1])
        elif (len(command) == 4):
            if (command[0] == 'nequals') or (command[0] == 'equals'):
                if ((type(command[2]) == str) and (command[2] not in nonVariables) and (command[2] not in variables)):
                    variables.insert(0, command[2])
                if ((type(command[1]) == str) and (command[1] not in nonVariables) and (command[1] not in variables)):
                    variables.insert(0, command[1])
                if ((type(command[3]) == str) and (command[3] not in nonVariables) and (command[3] not in variables)):
                    variables.insert(0, command[3])
            else:
                if ((type(command[2]) == str) and (command[2] not in nonVariables) and (command[2] not in variables)):
                    variables.insert(0, command[2])
                
                if ((type(command[3]) == str) and (command[3] not in nonVariables) and (command[3] not in variables)):
                    variables.insert(0, command[3])
        elif (len(command) == 5):
            if ((type(command[2]) == str) and (command[2] not in nonVariables) and (command[2] not in variables)):
                variables.insert(0, command[2])
            if ((type(command[3]) == str) and (command[3] not in nonVariables) and (command[3] not in variables)):
                variables.insert(0, command[3])
            if ((type(command[4]) == str) and (command[4] not in nonVariables) and (command[4] not in variables)):
                variables.insert(0, command[4])
        elif (len(command) == 6):
            if ((type(command[2]) == str) and (command[2] not in nonVariables) and (command[2] not in variables)):
                variables.insert(0, command[2])
            if ((type(command[3]) == str) and (command[3] not in nonVariables) and (command[3] not in variables)):
                variables.insert(0, command[3])
            if ((type(command[4]) == str) and (command[4] not in nonVariables) and (command[4] not in variables)):
                variables.insert(0, command[4])
            if ((type(command[5]) == str) and (command[5] not in nonVariables) and (command[5] not in variables)):
                variables.insert(0, command[5])
            

    return variables
    
    