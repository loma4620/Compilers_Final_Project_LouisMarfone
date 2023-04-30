#import sys

# determine whether a variable is already live
def alreadyLive(inputSet, val):
    if val in inputSet:
        return True
    return False

# add variables to liveness (bottom to top)
# L_before (k) = (L_after (k) − W (k)) ∪ R(k)
def liveness_analysis(IR_program, userFuncs, currLivenessStart=[]):
    print_like_functions = ['tag', 'is_int', 'is_bool', 'is_float', 'is_big', 'is_function', 'is_object', 'is_class', 'is_unbound_method', 'is_bound_method', 'inject_int', 'inject_bool', 'inject_float', 'inject_big', 'project_int', 'project_bool', 'project_float', 'project_big', 'project_function', 'project_class', 'project_object', 'project_bound_method', 'project_unbound_method', 'error_pyobj', 'is_true', 'get_fun_ptr', 'get_free_vars', 'create_list']
    multiParams = ['set_subscript', 'get_subscript', 'add', 'equal', 'not_equal', 'create_closure', 'set_free_vars']
    noParams = ['eval_input_pyobj', 'create_dict']
    liveness_array = [currLivenessStart]
    crawlerSet = set(currLivenessStart)

    for i, command in enumerate(IR_program):
        live_after = crawlerSet
        match command[0]:
            case 'addl':
                write_to = command[2]
                read_from2 = command[2]
                read_from1 = command[1]
                if (alreadyLive(live_after, write_to)):
                    live_after.remove(write_to)
                    
                if ((type(read_from1) == str) and (not alreadyLive(live_after, read_from1))):
                    # live_after = live_after + [read1_from]
                    live_after.add(read_from1)
                
                if ((type(read_from2) == str) and (not alreadyLive(live_after, read_from2))):
                    # live_after = live_after + [read2_from]
                    live_after.add(read_from2)

            case 'movl':
                write_to = command[2]
                read_from = command[1]
                if (alreadyLive(live_after, write_to)):
                    live_after.remove(write_to)

                if ((type(read_from) == str) and (not alreadyLive(live_after, read_from))):
                    live_after.add(read_from)

            case 'negl':
                write_to = command[2]
                read_from = command[2]
                if (alreadyLive(live_after, write_to)):
                    live_after.remove(write_to)
                
                if ((type(read_from) == str) and (not alreadyLive(live_after, read_from))):
                    live_after.add(read_from)

            case 'call':
                if (command[1] in noParams) and (command[3] != 'NULL'):
                    write_to = command[3]
                    if (alreadyLive(live_after, write_to)):
                        live_after.remove(write_to)
                elif (command[1] == 'print_any') and (command[3] == 'NULL'):
                    read_from = command[2]
                    if ((type(read_from) == str) and (not alreadyLive(live_after, read_from))):
                        live_after.add(read_from)
                elif (command[1] in print_like_functions) and (command[3] != 'NULL'):
                    read_from = command[2]
                    write_to = command[3]
                    if (alreadyLive(live_after, write_to)):
                        live_after.remove(write_to)
                
                    if ((type(read_from) == str) and (not alreadyLive(live_after, read_from))):
                        live_after.add(read_from)
                elif (command[1] in multiParams) and (command[len(command)-1] != 'NULL'):
                    write_to = command[len(command)-1]

                    if (alreadyLive(live_after, write_to)):
                        live_after.remove(write_to)

                    read_from1 = command[2]
                    read_from2 = command[3]
                    if (len(command) == 6):
                        read_from3 = command[4]
                    else:
                        read_from3 = None

                    if ((type(read_from1) == str) and (not alreadyLive(live_after, read_from1))):
                        live_after.add(read_from1)
                    
                    if ((type(read_from2) == str) and (not alreadyLive(live_after, read_from2))):
                        live_after.add(read_from2)

                    if (type(read_from3) != None):
                        if ((type(read_from3) == str) and (not alreadyLive(live_after, read_from3))):
                            live_after.add(read_from3)
                else:
                    write_to = command[len(command)-1]
                    if (alreadyLive(live_after, write_to)):
                        live_after.remove(write_to)
                    
                    params = []
                    for i in range(1, (len(command)-1)):
                        params.append(command[i])
                    
                    for read_from in params:
                        if ((type(read_from) == str) and (not alreadyLive(live_after, read_from))):
                            live_after.add(read_from)
            
            case 'equals':
                write_to = command[3]
                read_from1 = command[1]
                read_from2 = command[2]
                if (alreadyLive(live_after, write_to)):
                    live_after.remove(write_to)
                
                if ((type(read_from1) == str) and (not alreadyLive(live_after, read_from1))):
                    live_after.add(read_from1)
                
                if ((type(read_from2) == str) and (not alreadyLive(live_after, read_from2))):
                    live_after.add(read_from2)

            case 'nequals':
                write_to = command[3]
                read_from1 = command[1]
                read_from2 = command[2]
                if (alreadyLive(live_after, write_to)):
                    live_after.remove(write_to)
                
                if ((type(read_from1) == str) and (not alreadyLive(live_after, read_from1))):
                    live_after.add(read_from1)
                
                if ((type(read_from2) == str) and (not alreadyLive(live_after, read_from2))):
                    live_after.add(read_from2)

            case 'is':
                write_to = command[3]
                read_from1 = command[1]
                read_from2 = command[2]
                if (alreadyLive(live_after, write_to)):
                    live_after.remove(write_to)
                
                if ((type(read_from1) == str) and (not alreadyLive(live_after, read_from1))):
                    live_after.add(read_from1)
                
                if ((type(read_from2) == str) and (not alreadyLive(live_after, read_from2))):
                    live_after.add(read_from2)

            case 'not':
                write_to = command[2]
                read_from = command[1]
                if (alreadyLive(live_after, write_to)):
                    live_after.remove(write_to)
                
                if ((type(read_from) == str) and (not alreadyLive(live_after, read_from))):
                    live_after.add(read_from)

            case 'cmpl':
                read_from2 = command[2]
                read_from1 = command[1]
                
                if ((type(read_from1) == str) and (not alreadyLive(live_after, read_from1))):
                    live_after.add(read_from1)

                if ((type(read_from2) == str) and (not alreadyLive(live_after, read_from2))):
                    live_after.add(read_from2)
            case 'ret':
                read_from = command[1]

                if ((type(read_from) == str) and (not alreadyLive(live_after, read_from))):
                    live_after.add(read_from)
            case 'def':
                write_tos = []

                for i in range(2, len(command)):
                    write_tos.append(command[i])

                for i in write_tos:
                    if (alreadyLive(live_after, i)):
                        live_after.remove(i)
            case _:
                pass
        # set new L_before

        temp = list(live_after)

        liveness_array.append(temp)
    
    
    return liveness_array