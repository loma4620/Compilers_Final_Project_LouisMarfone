class InterferenceGraph():
    def __init__(self, elements, liveness, IR_prog):
        self.liveness = liveness
        self.variables = elements
        self.IR_prog = IR_prog
        self.InclusionSet = set()
        self.ExclusionSet = set()
        self.SolutionSet = set()
        self.adjDict = {
            'eax': ['tan', set()], 
            'ecx': ['green', set()], 
            'edx': ['blue', set()], 
            'edi': ['yellow', set()], 
            'ebx': ['pink', set()], 
            'esi': ['gray', set()]
        }
        self.constraints = {} # for coloring
        self.spillNum = 1

        # add vars to graph
        for v in self.variables:
            #the spilled temp variables are unspillable
            if (v == 'st1'):
                self.adjDict.update({v: ['tan', set()]})
            elif (v == 'st2'):
                self.adjDict.update({v: ['green', set()]})
            elif (v == 'st3'):
                self.adjDict.update({v: ['blue', set()]})
            elif (v == 'st4'):
                self.adjDict.update({v: ['yellow', set()]})
            elif (v == 'st5'):
                self.adjDict.update({v: ['pink', set()]})
            elif (v == 'st6'):
                self.adjDict.update({v: ['gray', set()]})
            else:
                self.adjDict.update({v: ['none', set()]})
                self.constraints.update({v: []})
            
            self.InclusionSet.add(v)
        
        self.colorPriority = {
            'tan': '1', 
            'green': '2', 
            'blue': '3', 
            'yellow': '4', 
            'pink': '5', 
            'gray': '6'
        }
        
        self.spilledVariables = []

        self.prog = ''

        self.runtimeFuncs = ["not_equal", "equal", "add", "set_free_vars", "is_true", "create_list", "creat_dict", "print", "print_int_nl", "print_any", "eval_input_int", "eval_input_pyobj", "is_int", "is_bool", "is_big", "is_float", "is_function", "is_object", "is_class", "is_unbound_method", "is_bound_method", "inject_int", "inject_bool", "inject_float", "inject_big", "project_int", "project_bool", "project_float", "project_big", "project_function", "project_class", "project_object", "project_bound_method", "project_unbound_method", "error_pyobj", "get_function", "get_fun_ptr", "get_free_vars", "set_free_vars", "create_closure", "get_subscript", "set_subscript"]
    
    def PrintGraph(self):
        print("adjacentcy lists")
        for key in self.adjDict:
            print(key + ": " + str(self.adjDict[key]))
        print("\n")
        
        print("colors")
        for key in self.colorPriority:
            print(key + ": " + str(self.colorPriority[key]))
        print("\n")

        print("constraints")
        for key in self.constraints:
            print(key + ": " + str(self.constraints[key]))
        print("\n")

        print("spilled variables:" + str(self.spilledVariables) + '\n')

    def CreateGraph(self):
        for i, command in enumerate(self.IR_prog):
            # self.PrintGraph()
            #L_before (k) = (L_after (k) − W (k)) ∪ R(k)
            match command[0]:
                case 'def':
                    for i in range(2, len(command)):
                        for x in range(2, len(command)):
                            if (command[i] != command[x]) and (command[i] not in self.adjDict[command[x]][1]):
                                self.adjDict[command[x]][1].add(command[i])
                case 'movl':
                    target = command[2]
                    source = command[1]
                    # print(self.liveness[i])
                    for var in self.liveness[i]:
                        if (var != source):
                            if (var != target) and (var != 'NULL') and (target != 'NULL'):
                                if var not in self.adjDict[target][1]:
                                    self.adjDict[target][1].add(var)
                                if target not in self.adjDict[var][1]:
                                    self.adjDict[var][1].add(target)

                case 'addl':
                    target = command[2]
                    for var in self.liveness[i]:
                        if (var != target) and (var != 'NULL') and (target != 'NULL'):
                            if var not in self.adjDict[target][1]:
                                self.adjDict[target][1].add(var)
                            if target not in self.adjDict[var][1]:
                                self.adjDict[var][1].add(target)

                case 'negl':
                    target = command[2]
                    for var in self.liveness[i]:
                        if (var != target) and (var != 'NULL') and (target != 'NULL'):
                            if var not in self.adjDict[target][1]:
                                self.adjDict[target][1].add(var)
                            if target not in self.adjDict[var][1]:
                                self.adjDict[var][1].add(target)
                
                case 'call':
                    caller_saved = ['eax', 'edx', 'ecx']
                    if (len(command) == 4): 
                        target = command[3]
                    elif (len(command) == 5):
                        target = command[4]
                    else:
                        target = command[5]
                    
                    for after in self.liveness[i]:
                        if (after != 'NULL'):
                            if (after != target) and (target != 'NULL'):
                                if target not in self.adjDict[after][1]:
                                    self.adjDict[after][1].add(target)
                                if after not in self.adjDict[target][1]:
                                    self.adjDict[target][1].add(after)
                            if (after in self.liveness[i+1]):
                                for reg in caller_saved:
                                    if (reg not in self.adjDict[after][1]):
                                        self.adjDict[after][1].add(reg)
                                    if (after not in self.adjDict[reg][1]) and (target != 'NULL'):
                                        self.adjDict[reg][1].add(target)
                
                case 'not':
                    target = command[2]
                    for var in self.liveness[i]:
                        if (var != 'NULL') and (target != 'NULL') and (var != target):
                            if var not in self.adjDict[target][1]:
                                self.adjDict[target][1].add(var)
                            if target not in self.adjDict[var][1]:
                                self.adjDict[var][1].add(target)

                case 'equals':
                    target = command[3]
                    for var in self.liveness[i]:
                        if (var != target) and (var != 'NULL') and (target != 'NULL'):
                            if var not in self.adjDict[target][1]:
                                self.adjDict[target][1].add(var)
                            if target not in self.adjDict[var][1]:
                                self.adjDict[var][1].add(target)
                    
                    for var in self.liveness[i]:
                        if (var != 'NULL'):
                            if var not in self.adjDict['eax'][1]:
                                self.adjDict['eax'][1].add(var)
                            if 'eax' not in self.adjDict[var][1]:
                                self.adjDict[var][1].add('eax')

                case 'nequals':
                    target = command[3]
                    for var in self.liveness[i]:
                        if (var != target) and (var != 'NULL') and (target != 'NULL'):
                            if var not in self.adjDict[target][1]:
                                self.adjDict[target][1].add(var)
                            if target not in self.adjDict[var][1]:
                                self.adjDict[var][1].add(target)
                    
                    for var in self.liveness[i]:
                        if (var != 'NULL'):
                            if var not in self.adjDict['eax'][1]:
                                self.adjDict['eax'][1].add(var)
                            if 'eax' not in self.adjDict[var][1]:
                                self.adjDict[var][1].add('eax')
                
                case 'is':
                    target = command[3]
                    for var in self.liveness[i]:
                        if (var != target) and (var != 'NULL') and (target != 'NULL'):
                            if var not in self.adjDict[target][1]:
                                self.adjDict[target][1].add(var)
                            if target not in self.adjDict[var][1]:
                                self.adjDict[var][1].add(target)
                    
                    for var in self.liveness[i]:
                        if (var != 'NULL'):
                            if var not in self.adjDict['eax'][1]:
                                self.adjDict['eax'][1].add(var)
                            if 'eax' not in self.adjDict[var][1]:
                                self.adjDict[var][1].add('eax')

                case 'cmpl':
                    for var in self.liveness[i]:
                        if (var != 'NULL'):
                            if var not in self.adjDict['eax'][1]:
                                self.adjDict['eax'][1].add(var)
                            if 'eax' not in self.adjDict[var][1]:
                                self.adjDict[var][1].add('eax')

    #Graph coloring Greedy --------------------------------------------------------------------------------

    def GetNodeColor(self, target):
        color = 'none'
        if (target in self.adjDict.keys()):
            color = self.adjDict[target][0]

        return color
    
    def GetReg(self, color):
        for node in self.adjDict:
            if ((self.adjDict[node][0] == color) and (node not in self.variables)):
                return node
        
        return 'NULL'

    def UpdateConstraints(self, adjlist):
        for var in adjlist: # scan through adj list
            if ((var in self.variables) and (var in self.constraints)):
                temp = self.constraints[var]
                if (len(temp) < 6):
                    for adj in self.adjDict[var][1]:
                        adjColor = self.GetNodeColor(adj)
                        if (adjColor != 'none'):
                            reg = self.GetReg(adjColor)
                            if (reg not in temp) and (reg != 'NULL'):
                                temp.append(reg)
                    self.constraints.update({var: temp})
                
                if (len(temp) == 6): # it spills
                    self.spilledVariables.append(var)
                    stack_placement = '-' + str(self.spillNum*4) + '(%ebp)'
                    self.adjDict[var][0] = stack_placement
                    self.spillNum += 1
                    self.constraints.pop(var)

    def GetLeastConstrained(self):
        leastConstraints = 0
        leastConstrainedKey = 'NULL'
        for key in self.constraints:
            curr = len(self.constraints[key])
            if (curr == 6):
                return key
            if (curr > leastConstraints):
                leastConstraints = curr
                leastConstrainedKey = key

        if (leastConstrainedKey == 'NULL'):
            variables = list(self.constraints.keys())
            leastConstrainedKey = variables[0]
        
        return leastConstrainedKey
    
    def ColorGraph(self):
        self.UpdateConstraints(list(self.adjDict.keys()))
        while (len(self.constraints) != 0):
            # self.PrintGraph()
            nextVar = self.GetLeastConstrained()
            for color in self.colorPriority:
                reg = self.GetReg(color)
                if (reg not in self.constraints[nextVar]):
                    self.adjDict[nextVar][0] = color
                    self.constraints.pop(nextVar)
                    break
            
            self.UpdateConstraints(list(self.adjDict[nextVar][1]))
    
    #Color Graph RLF ------------------------------------------------------------------------------------------

    def ColorGraphRLF(self):
        i = 0
        while (len(self.InclusionSet) != 0):
            if (i >= 6):
                #if all colors have been assigned add the remaining vertices to spilled variables
                for spilled in self.InclusionSet:
                    self.spilledVariables.append(spilled)
                    stack_placement = '-' + str(self.spillNum*4) + '(%ebp)'
                    self.adjDict[spilled][0] = stack_placement
                    self.spillNum += 1
                    self.SolutionSet.add(spilled) 
                self.InclusionSet = set()   
            else:
                currColor = list(self.colorPriority.keys())[i]
                i += 1
                while(len(self.InclusionSet) != 0):
                    v = self.InclusionSet.pop()
                    repick = False
                    noMoreRegs = False
                    for vertex in self.adjDict[v][1]:
                        if (self.adjDict[vertex][0] == currColor):
                            repick=True
                    
                    tempV = []
                    while (repick):
                        tempV.append(v)
                        if (len(self.InclusionSet) != 0):
                            v = self.InclusionSet.pop()
                            for vertex in self.adjDict[v][1]:
                                if (self.adjDict[vertex][0] == currColor):
                                    repick=True
                                    break
                                else:
                                    repick=False
                        else:
                            repick = False
                            noMoreRegs = True
                            
                    if (noMoreRegs):
                        for idx in tempV:
                            self.ExclusionSet.add(idx)
                        break

                    for index in tempV:
                        self.InclusionSet.add(index)
                    
                    self.adjDict[v][0] = currColor
                    for adj in self.adjDict[v][1]:
                        if (adj in self.InclusionSet):
                            self.ExclusionSet.add(adj)

                self.InclusionSet = self.ExclusionSet
                self.ExclusionSet = set()
             

    # Assign Homes Functions----------------------------------------------------------------------------------------------------

    def jumpLocationsHelper(self, command):
        jumpName = command[0][:-1]
        jumpNum = command[1]

        self.prog = self.prog + " " + jumpName + str(jumpNum) + ":\n"

    def assignHomes(self, correctedIR):
        paramCount = []
        if len(correctedIR) > 0 and (correctedIR[0][0] == 'def'):
            functionName = correctedIR[0][1]
            self.prog = self.prog + functionName + ":\n"
            for i in range(2, len(correctedIR[0])):
                paramCount.append(correctedIR[0][i])
        else:
            self.prog = self.prog + ".global main\nmain:\n"

        self.prog = self.prog + " pushl %ebp\n movl %esp, %ebp\n"
        self.prog = self.prog + " subl $" + str(len(self.spilledVariables)*4) + ", %esp\n"

        CalleeSavedColors = [self.adjDict['edi'][0], self.adjDict['ebx'][0], self.adjDict['esi'][0]]
        pushedRegisters = []
        for color in CalleeSavedColors:
            for var in self.adjDict:
                if ((var in self.variables) and (self.adjDict[var][0] == color)):
                    reg = self.GetReg(color)
                    if (reg not in pushedRegisters):
                        self.prog = self.prog + " pushl %" + reg + "\n"
                        pushedRegisters.insert(0, reg)

        if (len(paramCount) > 0):
            for idx, param in enumerate(paramCount):
                param_home = ''
                if (type(param) != int) and (type(param) != bool):
                    if (param not in self.spilledVariables):
                        param_home = "%" + self.GetReg(self.adjDict[param][0])
                    else:
                        param_home = self.adjDict[param][0]
                else:
                    if (type(param) == int):
                        param_home = "$" + str(param)
                    else:
                        if (param == False):
                            param_home = "$0"
                        else:
                            param_home = "$1"
                
                if param in self.spilledVariables:
                    self.prog = self.prog + " movl " + str((2+idx)*4) + "(%ebp), %eax\n movl %eax, " + param_home + "\n"
                else:
                    self.prog = self.prog + " movl " + str((2+idx)*4) + "(%ebp), " + param_home + "\n"

        returnValue = "$0"
        for command in correctedIR:
            match command[0]:
                case 'movl':
                    param = command[1]
                    target = command[2]
                    param_home = ''
                    target_home = ''
                    if (type(param) != int) and (type(param) != bool):
                        param_color = self.GetNodeColor(param)
                    else:
                        param_color = 'int1'
                    if (type(target) != int):
                        target_color = self.GetNodeColor(target)
                    else:
                        target_color = 'int2'

                    if (type(param) != int) and (type(param) != bool):
                        if (param not in self.spilledVariables):
                            param_home = "%" + self.GetReg(self.adjDict[param][0])
                        else:
                            param_home = self.adjDict[param][0]
                    else:
                        if (type(param) == int):
                            param_home = "$" + str(param)
                        else:
                            if (param == False):
                                param_home = "$0"
                            else:
                                param_home = "$1"
                    
                    if (target not in self.spilledVariables):
                            target_home = "%" + self.GetReg(self.adjDict[target][0])
                    else:
                            target_home = self.adjDict[target][0]
                    
                    
                    if (param_color != target_color):
                        self.prog = self.prog + " movl " + param_home + ", " + target_home + "\n"
                
                case 'addl':
                    param = command[1]
                    target = command[2]
                    param_home = ''
                    target_home = ''

                    if (type(param) != int) and (type(param) != bool):
                        if (param not in self.spilledVariables):
                            param_home = "%" + self.GetReg(self.adjDict[param][0])
                        else:
                            param_home = self.adjDict[param][0]
                    else:
                        if (type(param) == int):
                            param_home = "$" + str(param)
                        else:
                            if (param == False):
                                param_home = "$0"
                            else:
                                param_home = "$1"
                    
                    if (target not in self.spilledVariables):
                            target_home = "%" + self.GetReg(self.adjDict[target][0])
                    else:
                            target_home = self.adjDict[target][0]

                    self.prog = self.prog + " addl " + param_home + ", " + target_home + "\n"
                
                case 'negl':
                    target = command[2]
                    target_home = ''

                    if (target not in self.spilledVariables):
                            target_home = "%" + self.GetReg(self.adjDict[target][0])
                    else:
                            target_home = self.adjDict[target][0]

                    self.prog = self.prog + " negl " + target_home + "\n"
                
                case 'call':
                    if (len(command) <= 4):
                        target = command[3]
                        param = command[2]
                        target_home = ''
                        param_home = ''

                        if (param != 'NULL'):
                            if (type(param) != int) and (type(param) != bool):
                                if (param not in self.spilledVariables):
                                    param_home = "%" + self.GetReg(self.adjDict[param][0])
                                else:
                                    param_home = self.adjDict[param][0]
                            else:
                                if (type(param) == int):
                                    param_home = "$" + str(param)
                                else:
                                    if (param == False):
                                        param_home = "$0"
                                    else:
                                        param_home = "$1"

                        if (target != 'NULL'):
                            if (target not in self.spilledVariables):
                                    target_home = "%" + self.GetReg(self.adjDict[target][0])
                            else:
                                    target_home = self.adjDict[target][0]
                        
                        if ((command[1] == 'eval_input_pyobj' or command[1] == 'create_dict') and target != 'NULL'):
                            if (self.adjDict[target][0] == 'tan'):
                                self.prog = self.prog + " call " + command[1] + "\n"
                            else:
                                self.prog = self.prog + " call " + command[1] + "\n movl %eax, " + target_home + "\n"
                        else:
                            functionName = ''
                            if (command[1] in self.runtimeFuncs):
                                functionName = command[1]
                            else:
                                if (command[1] not in self.spilledVariables):
                                    functionName = "%" + self.GetReg(self.adjDict[command[1]][0])
                                else:
                                    self.prog = self.prog + " movl " + self.adjDict[command[1]][0] + ", %eax\n"
                                    functionName = "%eax"

                            if (command[1] != 'eval_input_pyobj'):
                                if (target != 'NULL'):
                                    self.prog = self.prog + " pushl " + param_home + "\n call " + functionName + "\n movl %eax, " + target_home + "\n" + " addl $4, %esp\n"
                                else:
                                    self.prog = self.prog + " pushl " + param_home + "\n call " + functionName + "\n addl $4, %esp\n"
                    elif (len(command) == 5):
                        target_home = ''
                        param1_home = ''
                        param2_home = ''
                        
                        target = command[4]
                        param1 = command[2]
                        if (command[1] == 'create_closure'):
                            param2 = 'NULL'
                            param2_home = '$' + command[3]
                        else:
                            param2 = command[3]

                        if (param1 != 'NULL'):
                            if (type(param1) != int) and (type(param1) != bool):
                                if (param1 not in self.spilledVariables):
                                    param1_home = "%" + self.GetReg(self.adjDict[param1][0])
                                else:
                                    param1_home = self.adjDict[param1][0]
                            else:
                                if (type(param1) == int):
                                    param1_home = "$" + str(param1)
                                else:
                                    if (param1 == False):
                                        param1_home = "$0"
                                    else:
                                        param1_home = "$1"
                        
                        if (param2 != 'NULL'):
                            if (type(param2) != int) and (type(param2) != bool):
                                if (param2 not in self.spilledVariables):
                                    param2_home = "%" + self.GetReg(self.adjDict[param2][0])
                                else:
                                    param2_home = self.adjDict[param2][0]
                            else:
                                if (type(param2) == int):
                                    param2_home = "$" + str(param2)
                                else:
                                    if (param2 == False):
                                        param2_home = "$0"
                                    else:
                                        param2_home = "$1"
                        
                        if (target != 'NULL'):
                            if (target not in self.spilledVariables):
                                    target_home = "%" + self.GetReg(self.adjDict[target][0])
                            else:
                                    target_home = self.adjDict[target][0]

                        if (param1_home != ''):    
                            self.prog = self.prog + " pushl " + param1_home + "\n"
                        
                        if (param2_home != ''):    
                            self.prog = self.prog + " pushl " + param2_home + "\n"
                        
                        functionName = ''
                        if (command[1] in self.runtimeFuncs):
                            functionName = command[1]
                        else:
                            if (command[1] not in self.spilledVariables):
                                functionName = "%" + self.GetReg(self.adjDict[command[1]][0])
                            else:
                                self.prog = self.prog + " movl " + self.adjDict[command[1]][0] + ", %eax\n"
                                functionName = "%eax"
                        
                        if (target != 'NULL'):
                            self.prog = self.prog + " call " + functionName + "\n movl %eax, " + target_home + "\n" + " addl $8, %esp\n"
                        else:
                            self.prog = self.prog + " call " + functionName + "\n addl $8, %esp\n"
                    elif (len(command) == 6):
                        target = command[5]
                        param1 = command[2]
                        param2 = command[3]
                        param3 = command[4]
                        target_home = ''
                        param1_home = ''
                        param2_home = ''
                        param3_home = ''

                        if (param1 != 'NULL'):
                            if (type(param1) != int) and (type(param1) != bool):
                                if (param1 not in self.spilledVariables):
                                    param1_home = "%" + self.GetReg(self.adjDict[param1][0])
                                else:
                                    param1_home = self.adjDict[param1][0]
                            else:
                                if (type(param1) == int):
                                    param1_home = "$" + str(param1)
                                else:
                                    if (param1 == False):
                                        param1_home = "$0"
                                    else:
                                        param1_home = "$1"
                        
                        if (param2 != 'NULL'):
                            if (type(param2) != int) and (type(param2) != bool):
                                if (param2 not in self.spilledVariables):
                                    param2_home = "%" + self.GetReg(self.adjDict[param2][0])
                                else:
                                    param2_home = self.adjDict[param2][0]
                            else:
                                if (type(param2) == int):
                                    param2_home = "$" + str(param2)
                                else:
                                    if (param2 == False):
                                        param2_home = "$0"
                                    else:
                                        param2_home = "$1"
                        
                        if (param3 != 'NULL'):
                            if (type(param3) != int) and (type(param3) != bool):
                                if (param3 not in self.spilledVariables):
                                    param3_home = "%" + self.GetReg(self.adjDict[param3][0])
                                else:
                                    param3_home = self.adjDict[param3][0]
                            else:
                                if (type(param3) == int):
                                    param3_home = "$" + str(param3)
                                else:
                                    if (param3 == False):
                                        param3_home = "$0"
                                    else:
                                        param3_home = "$1"
                        
                        if (target != 'NULL'):
                            if (target not in self.spilledVariables):
                                    target_home = "%" + self.GetReg(self.adjDict[target][0])
                            else:
                                    target_home = self.adjDict[target][0]

                        if (param1 != 'NULL'):    
                            self.prog = self.prog + " pushl " + param1_home + "\n"
                        
                        if (param2 != 'NULL'):    
                            self.prog = self.prog + " pushl " + param2_home + "\n"

                        if (param3 != 'NULL'):    
                            self.prog = self.prog + " pushl " + param3_home + "\n"
                        
                        functionName = ''
                        if (command[1] in self.runtimeFuncs):
                            functionName = command[1]
                        else:
                            if (command[1] not in self.spilledVariables):
                                functionName = "%" + self.GetReg(self.adjDict[command[1]][0])
                            else:
                                self.prog = self.prog + " movl " + self.adjDict[command[1]][0] + ", %eax\n"
                                functionName = "%eax"
                        
                        if (target != 'NULL'):
                            self.prog = self.prog + " call " + functionName + "\n movl %eax, " + target_home + "\n" + " addl $12, %esp\n"
                        else:
                            self.prog = self.prog + " call " + functionName + "\n addl $12, %esp\n"
                    elif (len(command) == 7):
                        target = command[6]
                        param1 = command[2]
                        param2 = command[3]
                        param3 = command[4]
                        param4 = command[5]
                        target_home = ''
                        param1_home = ''
                        param2_home = ''
                        param3_home = ''
                        param4_home = ''

                        if (param1 != 'NULL'):
                            if (type(param1) != int) and (type(param1) != bool):
                                if (param1 not in self.spilledVariables):
                                    param1_home = "%" + self.GetReg(self.adjDict[param1][0])
                                else:
                                    param1_home = self.adjDict[param1][0]
                            else:
                                if (type(param1) == int):
                                    param1_home = "$" + str(param1)
                                else:
                                    if (param1 == False):
                                        param1_home = "$0"
                                    else:
                                        param1_home = "$1"
                        
                        if (param2 != 'NULL'):
                            if (type(param2) != int) and (type(param2) != bool):
                                if (param2 not in self.spilledVariables):
                                    param2_home = "%" + self.GetReg(self.adjDict[param2][0])
                                else:
                                    param2_home = self.adjDict[param2][0]
                            else:
                                if (type(param2) == int):
                                    param2_home = "$" + str(param2)
                                else:
                                    if (param2 == False):
                                        param2_home = "$0"
                                    else:
                                        param2_home = "$1"
                        
                        if (param3 != 'NULL'):
                            if (type(param3) != int) and (type(param3) != bool):
                                if (param3 not in self.spilledVariables):
                                    param3_home = "%" + self.GetReg(self.adjDict[param3][0])
                                else:
                                    param3_home = self.adjDict[param3][0]
                            else:
                                if (type(param3) == int):
                                    param3_home = "$" + str(param3)
                                else:
                                    if (param3 == False):
                                        param3_home = "$0"
                                    else:
                                        param3_home = "$1"
                        
                        if (param4 != 'NULL'):
                            if (type(param4) != int) and (type(param4) != bool):
                                if (param4 not in self.spilledVariables):
                                    param4_home = "%" + self.GetReg(self.adjDict[param4][0])
                                else:
                                    param4_home = self.adjDict[param4][0]
                            else:
                                if (type(param4) == int):
                                    param4_home = "$" + str(param4)
                                else:
                                    if (param4 == False):
                                        param4_home = "$0"
                                    else:
                                        param4_home = "$1"
                        
                        if (target != 'NULL'):
                            if (target not in self.spilledVariables):
                                    target_home = "%" + self.GetReg(self.adjDict[target][0])
                            else:
                                    target_home = self.adjDict[target][0]

                        if (param1 != 'NULL'):    
                            self.prog = self.prog + " pushl " + param1_home + "\n"
                        
                        if (param2 != 'NULL'):    
                            self.prog = self.prog + " pushl " + param2_home + "\n"

                        if (param3 != 'NULL'):    
                            self.prog = self.prog + " pushl " + param3_home + "\n"
                        
                        if (param4 != 'NULL'):    
                            self.prog = self.prog + " pushl " + param4_home + "\n"
                        
                        functionName = ''
                        if (command[1] in self.runtimeFuncs):
                            functionName = command[1]
                        else:
                            if (command[1] not in self.spilledVariables):
                                functionName = "%" + self.GetReg(self.adjDict[command[1]][0])
                            else:
                                self.prog = self.prog + " movl " + self.adjDict[command[1]][0] + ", %eax\n"
                                functionName = "%eax"
                        
                        if (target != 'NULL'):
                            self.prog = self.prog + " call " + functionName + "\n movl %eax, " + target_home + "\n" + " addl $12, %esp\n"
                        else:
                            self.prog = self.prog + " call " + functionName + "\n addl $16, %esp\n"
                    else:
                        target = command[len(command)-1]
                        for i in range(2, len(command)-1):
                            param = command[2]
                            param_home = ''

                            if (param != 'NULL'):
                                if (type(param) != int) and (type(param) != bool):
                                    if (param not in self.spilledVariables):
                                        param_home = "%" + self.GetReg(self.adjDict[param][0])
                                    else:
                                        param_home = self.adjDict[param][0]
                                else:
                                    if (type(param) == int):
                                        param_home = "$" + str(param)
                                    else:
                                        if (param == False):
                                            param_home = "$0"
                                        else:
                                            param_home = "$1"

                            if (param != 'NULL'):    
                                self.prog = self.prog + " pushl " + param_home + "\n"

                        if (target != 'NULL'):
                            if (target not in self.spilledVariables):
                                    target_home = "%" + self.GetReg(self.adjDict[target][0])
                            else:
                                    target_home = self.adjDict[target][0]

                        functionName = ''
                        if (command[1] in self.runtimeFuncs):
                            functionName = command[1]
                        else:
                            if (command[1] not in self.spilledVariables):
                                functionName = "%" + self.GetReg(self.adjDict[command[1]][0])
                            else:
                                self.prog = self.prog + " movl " + self.adjDict[command[1]][0] + ", %eax\n"
                                functionName = "%eax"
                        
                        if (target != 'NULL'):
                            self.prog = self.prog + " call " + functionName + "\n movl %eax, " + target_home + "\n" + " addl $12, %esp\n"
                        else:
                            self.prog = self.prog + " call " + functionName + "\n addl $16, %esp\n"
                            

                case 'nequals':
                    param1 = command[1]
                    param2 = command[2]
                    target = command[3]
                    param1_home = ''
                    param2_home = ''
                    target_home = ''

                    if (type(param1) != int) and (type(param1) != bool):
                        if (param1 not in self.spilledVariables):
                            param1_home = "%" + self.GetReg(self.adjDict[param1][0])
                        else:
                            param1_home = self.adjDict[param1][0]
                    else:
                        if (type(param1) == int):
                            param1_home = "$" + str(param1)
                        else:
                            if (param1 == False):
                                param1_home = "$0"
                            else:
                                param1_home = "$1"

                    if (type(param2) != int) and (type(param2) != bool):
                        if (param2 not in self.spilledVariables):
                            param2_home = "%" + self.GetReg(self.adjDict[param2][0])
                        else:
                            param2_home = self.adjDict[param2][0]
                    else:
                        if (type(param2) == int):
                            param2_home = "$" + str(param2)
                        else:
                            if (param2 == False):
                                param2_home = "$0"
                            else:
                                param2_home = "$1"

                    if (target not in self.spilledVariables):
                            target_home = "%" + self.GetReg(self.adjDict[target][0])
                    else:
                            target_home = self.adjDict[target][0]

                    self.prog = self.prog + " cmpl " + param1_home + ", " + param2_home + "\n"
                    self.prog = self.prog + " setne %al \n"
                    self.prog = self.prog + " movzbl %al, " + target_home + "\n"

                case 'equals':
                    param1 = command[1]
                    param2 = command[2]
                    target = command[3]
                    param1_home = ''
                    param2_home = ''
                    target_home = ''

                    if (type(param1) != int) and (type(param1) != bool):
                        if (param1 not in self.spilledVariables):
                            param1_home = "%" + self.GetReg(self.adjDict[param1][0])
                        else:
                            param1_home = self.adjDict[param1][0]
                    else:
                        if (type(param1) == int):
                            param1_home = "$" + str(param1)
                        else:
                            if (param1 == False):
                                param1_home = "$0"
                            else:
                                param1_home = "$1"

                    if (type(param2) != int) and (type(param2) != bool):
                        if (param2 not in self.spilledVariables):
                            param2_home = "%" + self.GetReg(self.adjDict[param2][0])
                        else:
                            param2_home = self.adjDict[param2][0]
                    else:
                        if (type(param2) == int):
                            param2_home = "$" + str(param2)
                        else:
                            if (param2 == False):
                                param2_home = "$0"
                            else:
                                param2_home = "$1"

                    if (target not in self.spilledVariables):
                            target_home = "%" + self.GetReg(self.adjDict[target][0])
                    else:
                            target_home = self.adjDict[target][0]

                    self.prog = self.prog + " cmpl " + param1_home + ", " + param2_home + "\n"
                    self.prog = self.prog + " sete %al \n"
                    self.prog = self.prog + " movzbl %al, " + target_home + "\n"
                
                case 'cmpl':
                    param = command[1]
                    target = command[2]
                    param_home = ''
                    target_home = ''

                    if (type(param) != int) and (type(param) != bool):
                        if (param not in self.spilledVariables):
                            param_home = "%" + self.GetReg(self.adjDict[param][0])
                        else:
                            param_home = self.adjDict[param][0]
                    else:
                        if (type(param) == int):
                            param_home = "$" + str(param)
                        else:
                            if (param == False):
                                param_home = "$0"
                            else:
                                param_home = "$1"
                    
                    if (type(target) != int):
                        if (target not in self.spilledVariables):
                                target_home = "%" + self.GetReg(self.adjDict[target][0])
                        else:
                                target_home = self.adjDict[target][0]
                    else:
                        target_home = "$" + str(target)

                    self.prog = self.prog + " cmpl " + param_home + ", " + target_home + "\n"
                
                case 'else:':
                    self.jumpLocationsHelper(command)
                
                case 'then:':
                    self.jumpLocationsHelper(command)
                
                case 'loop:':
                    self.jumpLocationsHelper(command)
                
                case 'while:':
                    self.jumpLocationsHelper(command)

                case 'endif:':
                    self.jumpLocationsHelper(command)
                
                case 'end:':
                    self.jumpLocationsHelper(command)
                
                case 'jmp':
                    location = command[1]
                    locationNum = command[2]

                    self.prog = self.prog + " jmp " + location + str(locationNum) + "\n"
                
                case 'je':
                    location = command[1]
                    locationNum = command[2]

                    self.prog = self.prog + " je " + location + str(locationNum) + "\n"
                
                case 'ret':
                    value = command[1]
                    if (type(value) != int) and (type(value) != bool):
                        if (value not in self.spilledVariables):
                            returnValue = "%" + self.GetReg(self.adjDict[value][0])
                        else:
                            returnValue = self.adjDict[value][0]
                    else:
                        if (type(value) == int):
                            returnValue = "$" + str(value)
                        else:
                            if (value == False):
                                returnValue = "$0"
                            else:
                                returnValue = "$1"

                case 'def':
                    pass
        
        self.prog = self.prog + " movl " + returnValue + ", %eax \n"
        for reg in pushedRegisters:
            self.prog = self.prog + " popl %" + reg + "\n"
        self.prog = self.prog + " movl %ebp, %esp\n popl %ebp\n ret\n"

        return self.prog

                        




