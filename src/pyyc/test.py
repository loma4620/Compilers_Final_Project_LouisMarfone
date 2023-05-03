import sys
import ast
from flat import *
from desugar import *
from IR import *
from InterferenceGraph import *
from explicate import *
from CFG import *
from uniquify import *
from closure import *

def runAgain(spilled, prevSpilled):
    for var in spilled:
        if var not in prevSpilled:
            return True
    
    return False

if __name__ == "__main__":

    file = sys.argv[1]
    filename = file.split(".py", 1)[0]
    prog = ''
    with open(file) as f:
        prog = f.read()

    tree = ast.parse(prog)

    # print("unflattened tree")
    # print(ast.dump(tree, indent=4)) 
    # print('\n')

    funcCounter = functionCounter()
    funcCounter.visit(tree)

    undeclaredFunctions = funcCounter.functions

    pa = ParentAdder()
    pa.visit(tree)

    uniquify = uniquifyVisitor()
    uniquify.visit(tree)

    pa.visit(tree)

    # print("uniquified tree")
    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    funcRearrange = functionRearranger(undeclaredFunctions)
    funcRearrange.visit(tree)

    # print(ast.dump(tree, indent=4))
    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    pa.visit(tree)

    unifier = unifyLambdas()
    unifier.visit(tree)

    lambdaHeapify = unifier.heapifyVars

    pa.visit(tree)

    funcCounter2 = functionCounter()
    funcCounter2.visit(tree)

    userFunctions = funcCounter2.functions

    pa.visit(tree)

    ast.fix_missing_locations(tree)
    print(ast.unparse(tree))
    # print(ast.dump(tree, indent=4))

    lambdaCount = unifier.lambdaCounter

    cv = closureVisitor(lambdaCount, lambdaHeapify)
    cv.visit(tree)

    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    # print('\n')
    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    userFuncs = []
    for i in range(cv.lambdaCounter):
        newFunc = 'lambda_' + str(i)
        userFuncs.append(newFunc)

    pa.visit(tree)

    convertCalls = convertClosureCalls()
    convertCalls.visit(tree)

    # print('\n')
    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    pa.visit(tree)

    heapifyVars = cv.heapifyVars
    for userDefFunc in userFunctions:
        if userDefFunc in heapifyVars:
            heapifyVars.remove(userDefFunc)

    heapify = heapifyVisitor(heapifyVars)
    heapify.visit(tree)

    # print('\n')
    # print(ast.dump(tree, indent=4))
    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    pa.visit(tree)

    ast.fix_missing_locations(tree)

    print("closed tree")
    print(ast.unparse(tree))
    print('\n')

    fv = flatteningVisitor()
    fv.visit(tree)

    # print('\n')
    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    flattenedTemps = fv.tempCount

    ast.fix_missing_locations(tree)
    
    print("flattened tree")
    output = open("flattened_tree.txt", "w")
    output.write(ast.unparse(tree))
    output.write('\n\n\n')
    output.write(ast.dump(tree, indent=4))
    print('\n')
    output.close()
    
    pa.visit(tree)

    ev = explicateVisitor(flattenedTemps)
    ev.visit(tree)
    ast.fix_missing_locations(tree)

    # print("explicated tree")
    # print(ast.dump(tree, indent=4))
    # print(ast.unparse(tree))
    # print('\n')

    pa.visit(tree)

    explicatedTemps = ev.tempCount

    fv2 = flatteningVisitor(explicatedTemps)
    fv2.visit(tree)

    # print(ast.dump(tree, indent=4))
    # ast.fix_missing_locations(tree)
    # print(ast.unparse(tree))
    # print('\n')

    flattenedTemps = fv2.tempCount
    pa.visit(tree)

    dv = desugaringVisitor(flattenedTemps)
    dv.visit(tree)

    ast.fix_missing_locations(tree)

    print("explicated, flattened, and desugared tree")
    output = open("explicated_tree.txt", "w")
    output.write(ast.unparse(tree))
    output.write('\n\n\n')
    output.write(ast.dump(tree, indent=4))
    print('\n')

    desugaredTemps = dv.tempCount

    functionNodes = []
    for node in tree.body:
        if isinstance(node, FunctionDef):
            functionNodes.append(node)
    
    for bodyFunc in functionNodes:
        tree.body.remove(bodyFunc)

    #assign registers for funcitons

    totalAssembly = ''
    printCount = 0
    ifCount = 0
    whileCount = 0

    assemblyOutput = open("assembly_out.txt", "w")
    for function in functionNodes:
        # generate IR
        IRGen = IRGenerator(ifCount, whileCount, desugaredTemps)
        IRGen.visit(function)
        func_IR_prog1 = IRGen.prog

        ifCount = IRGen.ifCounter
        whileCount = IRGen.whileCounter

        # for x in func_IR_prog1:
        #     print(x)
        # print('\n')

        # create cfg graph
        funcCFG = CFG(func_IR_prog1, printCount, userFuncs)
        funcCFG.CreateBasicBlocks()
        funcCFG.ConnectBasicBlocks()

        #perform liveness analysis
        totalFuncLiveness = funcCFG.ControlFlowLiveness()
        func_IR_NoLabels = funcCFG.ConcatInstructions() 

        funcCFG.PrintCFG()
        printCount += 1 

        #count varaibles in program for Interference graph
        funcVariables = variableCounterIR(func_IR_NoLabels)
        # print(funcVariables)

        #create interference graph
        funcIG = InterferenceGraph(funcVariables, totalFuncLiveness, func_IR_NoLabels)
        funcIG.CreateGraph()
        # funcIG.PrintGraph()
        funcIG.ColorGraph()

        #recreate repeate last 4 steps till there are no more spilled variables
        spilledFuncVariables = funcIG.spilledVariables
        oldFuncIR = func_IR_prog1
        newFuncIG = funcIG

        prevFuncSpilled = []

        while(runAgain(spilledFuncVariables, prevFuncSpilled)):
            # print("im in")
            for var in spilledFuncVariables:
                prevFuncSpilled.append(var)
            newFuncIR = RemakeIR(spilledFuncVariables, oldFuncIR)
            newFuncCFG = CFG(newFuncIR, printCount, userFuncs)
            newFuncCFG.CreateBasicBlocks()
            newFuncCFG.ConnectBasicBlocks()
            newFuncLiveness = newFuncCFG.ControlFlowLiveness()
            new_Func_NoLabels = newFuncCFG.ConcatInstructions()
            newFuncVariables = variableCounterIR(newFuncIR)
            newFuncIG = InterferenceGraph(newFuncVariables, newFuncLiveness, new_Func_NoLabels)
            newFuncIG.CreateGraph()
            newFuncIG.ColorGraph()
            spilledFuncVariables = newFuncIG.spilledVariables
            oldFuncIR = newFuncIR

        # newFuncIG.PrintGraph()
        
        correctedFuncIR = []
        func_IR_length = len(oldFuncIR)
        for i in range(len(oldFuncIR)):
            idx = func_IR_length - (i+1)
            correctedFuncIR.append(oldFuncIR[idx])

        funcAssembly = newFuncIG.assignHomes(correctedFuncIR)
        totalAssembly += funcAssembly
        totalAssembly +='\n'

        # assemblyOutput.write(totalAssembly)
    
    

    #assing registers for main
    IRGen = IRGenerator(ifCount, whileCount, desugaredTemps)
    IRGen.visit(tree)
    IR_prog1 = IRGen.prog

    # create cfg graph
    cfg = CFG(IR_prog1, printCount, userFuncs)
    cfg.CreateBasicBlocks()
    cfg.ConnectBasicBlocks()

    #perform liveness analysis
    totalLiveness = cfg.ControlFlowLiveness()
    IR_NoLabels = cfg.ConcatInstructions()  

    cfg.PrintCFG()

    #count varaibles in program for Interference graph
    progVariables = variableCounterIR(IR_NoLabels)

    # print(len(progVariables))

    #create interference graph
    IG = InterferenceGraph(progVariables, totalLiveness, IR_NoLabels)
    IG.CreateGraph()
    # IG.PrintGraph()
    IG.ColorGraph()

    # IG.PrintGraph()

    #recreate repeate last 4 steps till there are no more spilled variables
    spilledVariables = IG.spilledVariables
    oldIR = IR_prog1
    newIG = IG

    prevSpilled = []

    while(runAgain(spilledVariables, prevSpilled)):
        # print("im in")
        for var in spilledVariables:
            prevSpilled.append(var)
        newIR = RemakeIR(spilledVariables, oldIR)
        newCFG = CFG(newIR, printCount, userFuncs)
        newCFG.CreateBasicBlocks()
        newCFG.ConnectBasicBlocks()
        newLiveness = newCFG.ControlFlowLiveness()
        new_NoLabels = newCFG.ConcatInstructions()
        newVariables = variableCounterIR(newIR)
        newIG = InterferenceGraph(newVariables, newLiveness, new_NoLabels)
        newIG.CreateGraph()
        newIG.ColorGraph()
        spilledVariables = newIG.spilledVariables
        oldIR = newIR

    # newIG.PrintGraph()
    # newCFG.PrintCFG()
    #assign homes and generate .s file
    correctedIR = []
    IR_length = len(oldIR)
    for i in range(len(oldIR)):
        idx = IR_length - (i+1)
        correctedIR.append(oldIR[idx])
    
    IR_file = open("IR_output.txt", "w")
    for i in correctedIR:
        IR_file.write(str(i))
        IR_file.write('\n')
    IR_file.close()

    assembly = newIG.assignHomes(correctedIR)
    totalAssembly += assembly
    
    # print(assembly)
    assemblyOutput.write(totalAssembly)
    assemblyOutput.close()