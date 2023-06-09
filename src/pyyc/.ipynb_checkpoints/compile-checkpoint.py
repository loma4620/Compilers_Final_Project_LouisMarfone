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

    funcCounter = functionCounter()
    funcCounter.visit(tree)

    undeclaredFunctions = funcCounter.functions

    pa = ParentAdder()
    pa.visit(tree)

    uniquify = uniquifyVisitor()
    uniquify.visit(tree)

    pa.visit(tree)

    funcRearrange = functionRearranger(undeclaredFunctions)
    funcRearrange.visit(tree)

    uniquify = uniquifyVisitor()
    uniquify.visit(tree)

    pa.visit(tree)

    unifier = unifyLambdas()
    unifier.visit(tree)

    pa.visit(tree)

    funcCounter2 = functionCounter()
    funcCounter2.visit(tree)

    userFunctions = funcCounter2.functions

    pa.visit(tree)

    lambdaCount = unifier.lambdaCounter

    cv = closureVisitor(lambdaCount, set())
    cv.visit(tree)

    userFuncs = []
    for i in range(cv.lambdaCounter):
        newFunc = 'lambda_' + str(i)
        userFuncs.append(newFunc)

    pa.visit(tree)

    convertCalls = convertClosureCalls()
    convertCalls.visit(tree)

    pa.visit(tree)

    heapifyVars = cv.heapifyVars
    for userDefFunc in userFunctions:
        if userDefFunc in heapifyVars:
            heapifyVars.remove(userDefFunc)
    
    heapify = heapifyVisitor(heapifyVars, [])
    heapify.visit(tree)

    ast.fix_missing_locations(tree)

    pa.visit(tree)

    fv = flatteningVisitor()
    fv.visit(tree)

    flattenedTemps = fv.tempCount

    ast.fix_missing_locations(tree)

    pa.visit(tree)

    ev = explicateVisitor(flattenedTemps)
    ev.visit(tree)
    ast.fix_missing_locations(tree)

    pa.visit(tree)

    explicatedTemps = ev.tempCount

    fv2 = flatteningVisitor(explicatedTemps)
    fv2.visit(tree)

    flattenedTemps = fv2.tempCount
    pa.visit(tree)

    dv = desugaringVisitor(flattenedTemps)
    dv.visit(tree)

    ast.fix_missing_locations(tree)

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
    whileCount = 0
    ifCount = 0
    for function in functionNodes:
        # generate IR
        IRGen = IRGenerator(ifCount, whileCount, desugaredTemps)
        IRGen.visit(function)
        func_IR_prog1 = IRGen.prog
        
        whileCout = IRGen.whileCounter
        ifCount = IRGen.ifCounter

        # create cfg graph
        funcCFG = CFG(func_IR_prog1, printCount, userFuncs)
        funcCFG.CreateBasicBlocks()
        funcCFG.ConnectBasicBlocks()

        #perform liveness analysis
        totalFuncLiveness = funcCFG.ControlFlowLiveness()
        func_IR_NoLabels = funcCFG.ConcatInstructions()  

        #count varaibles in program for Interference graph
        funcVariables = variableCounterIR(func_IR_NoLabels)

        #create interference graph
        funcIG = InterferenceGraph(funcVariables, totalFuncLiveness, func_IR_NoLabels)
        funcIG.CreateGraph()
        # funcIG.ColorGraph()
        funcIG.ColorGraphRLF()

        #recreate repeate last 4 steps till there are no more spilled variables
        spilledFuncVariables = funcIG.spilledVariables
        oldFuncIR = func_IR_prog1
        newFuncIG = funcIG

        prevFuncSpilled = []

        while(runAgain(spilledFuncVariables, prevFuncSpilled)):
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
            # newFuncIG.ColorGraph()
            newFuncIG.ColorGraphRLF()
            spilledFuncVariables = newFuncIG.spilledVariables
            oldFuncIR = newFuncIR
        
        correctedFuncIR = []
        func_IR_length = len(oldFuncIR)
        for i in range(len(oldFuncIR)):
            idx = func_IR_length - (i+1)
            correctedFuncIR.append(oldFuncIR[idx])

        funcAssembly = newFuncIG.assignHomes(correctedFuncIR)
        totalAssembly += funcAssembly
        totalAssembly +='\n'


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

    #count varaibles in program for Interference graph
    progVariables = variableCounterIR(IR_NoLabels)

    #create interference graph
    IG = InterferenceGraph(progVariables, totalLiveness, IR_NoLabels)
    IG.CreateGraph()
    # IG.ColorGraph()
    IG.ColorGraphRLF()

    #recreate repeate last 4 steps till there are no more spilled variables
    spilledVariables = IG.spilledVariables
    oldIR = IR_prog1
    newIG = IG

    prevSpilled = []

    while(runAgain(spilledVariables, prevSpilled)):
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
        # newIG.ColorGraph()
        newIG.ColorGraphRLF()
        spilledVariables = newIG.spilledVariables
        oldIR = newIR

    #assign homes and generate .s file
    correctedIR = []
    IR_length = len(oldIR)
    for i in range(len(oldIR)):
        idx = IR_length - (i+1)
        correctedIR.append(oldIR[idx])

    assembly = newIG.assignHomes(correctedIR)
    totalAssembly += assembly
    
    file_out = filename + ".s"
    output = open(file_out, "w")
    output.write(totalAssembly)
    output.close()