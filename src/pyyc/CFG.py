from liveness import *
from queue import *
from InterferenceGraph import *
from variableCounter import *

class vertex():
    def __init__(self, IR, BlockId):
        self.first_instruction = []
        self.last_instruction = []
        self.instructions = IR
        self.BlockId = BlockId
        self.liveness = [[]]
        self.LiveUp = []
        self.adjVertices = set()
        self.head = False


class CFG():
    def __init__(self, totalIR, printCount, userFuncs):
        self.userFuncs = userFuncs  
        self.vertices = []
        self.IR = totalIR
        self.currBlockId = 0
        self.totalLiveness = []
        self.printCount = printCount

    #concatenate instructions of all BBs for interference graph
    def ConcatInstructions(self):
        totalIR = []
        for vertex in self.vertices:
            for instruction in vertex.instructions:
                totalIR.insert(0, instruction)
        
        return totalIR

    #get head of graph 
    def GetHead(self):
        for vertex in self.vertices:
            if vertex.head == True:
                return vertex
        return None
    
    #inverts a given list
    def InvertIR(self, IR):
        idx = 0
        correctedlst = []

        elementLength = len(IR)
        for i in range(len(IR)):
            idx = elementLength - (i+1)
            correctedlst.append(IR[idx])
        
        return correctedlst

    #creates a new vertex for graph
    def insertVertex(self, instructions):
        v = vertex(instructions, self.currBlockId)
        if (len(instructions) != 0):
            v.first_instruction = v.instructions[0]
            v.last_instruction = v.instructions[len(v.instructions) - 1]
        else:
            v.first_instruction = ['none']
            v.last_instruction = ['none']
        self.currBlockId += 1
        if len(self.vertices) > 0:
            currHead = self.GetHead()
            currHead.head = False
        v.head = True
        self.vertices.insert(0, v)
    
    #creates basic blocks of cfg
    def CreateBasicBlocks(self):
        BasicBlockInstructions = []
        for command in self.IR:
            if command[0] != 'LABEL':
                BasicBlockInstructions.insert(0, command)
            else:
                self.insertVertex(BasicBlockInstructions)
                BasicBlockInstructions = []

        self.insertVertex(BasicBlockInstructions)

        headNode = self.GetHead()   
        if (len(headNode.instructions) == 0):
            nextVertex = self.GetVertexById(headNode.BlockId-1)
            if (nextVertex != None):
                nextVertex.head = True
            self.vertices.remove(headNode)
    
    #finds a node whose first command has matching op command and number
    def findNode(self, op, num):
        for vertex in self.vertices:
            if (len(vertex.first_instruction) == 2):
                if ((vertex.first_instruction[0] == op) and (vertex.first_instruction[1] == num)):
                    return vertex
            
        return None
    
    def findNodeByLast(self, op, num):
        for vertex in self.vertices:
            if (len(vertex.last_instruction) == 3):
                if ((vertex.last_instruction[1] == op) and (vertex.last_instruction[2] == num)):
                    return vertex
            
        return None
                
    def GetVertexById(self, Id):
        for vertex in self.vertices:
            if (vertex.BlockId == Id):
                return vertex
                
    def connectWhileConditions(self):
        prevVertexId = 0
        prevVertex = None
        nextVertexId = 0
        nextVertex = None
        #this function connects the blocks before the conditions of a while loop to the condion block and the end
        #blocks after teh end of a while loop to the end block
        for vertex in self.vertices:
            if (vertex.first_instruction[0] == 'while:'):
                #when you find the conditions you get the block immediately preceeding it and connect them
                prevVertexId = vertex.BlockId + 1
                prevVertex = self.GetVertexById(prevVertexId)
                if (prevVertex != None):
                    prevVertex.adjVertices.add(vertex.BlockId)

            if (vertex.first_instruction[0] == 'end:'):
                #if end of a while loop is followed by an else block it is the end of a then block and must redirect around the else
                nextVertexId = vertex.BlockId - 1
                nextVertex = self.GetVertexById(nextVertexId)
                if (nextVertex != None) and (nextVertex.first_instruction[0] == 'else:'):
                    Next = self.findNode('endif:', nextVertex.first_instruction[1])
                    vertex.adjVertices.add(Next.BlockId)
                
                #when you find the end of a while loop you get the block immediately after it and connect it.
                if (vertex.last_instruction[0] != 'je') and (len(vertex.instructions) > 1):
                    nextVertexId = vertex.BlockId - 1
                    if (nextVertexId >= 0):
                        nextVertex = self.GetVertexById(nextVertexId)
                        vertex.adjVertices.add(nextVertex.BlockId)

            # if an endif is followed by and else block it is already in an if statement and must be redirected to the next endif
            if (vertex.first_instruction[0] == 'endif:'):
                nextVertexId = vertex.BlockId - 1
                nextVertex = self.GetVertexById(nextVertexId)
                if (nextVertex != None) and (nextVertex.first_instruction[0] == 'else:'):
                    Next = self.findNode('endif:', nextVertex.first_instruction[1])
                    vertex.adjVertices.add(Next.BlockId)
                elif len(vertex.adjVertices) == 0 and (nextVertex != None) and (nextVertex.first_instruction[0] != 'end:'):
                    vertex.adjVertices.add(nextVertex.BlockId)


    def ConnectBasicBlocks(self):
        thenVertex = None
        elseVertex = None
        loopVertex = None
        whileVertex = None
        endVertex = None

        self.connectWhileConditions()
        for BB in self.vertices:
            if BB.last_instruction[0] == 'je':
                #could be an if statement or and loop condition
                
                if BB.last_instruction[1] == 'else':
                    thenVertex = self.findNode('then:', BB.last_instruction[2])
                    elseVertex = self.findNode('else:', BB.last_instruction[2])
                    if (elseVertex == None):
                        BB.adjVertices.add(thenVertex.BlockId)
                    else:
                        #add corresponding else and then BB to current BB adj list
                        BB.adjVertices.add(thenVertex.BlockId)
                        BB.adjVertices.add(elseVertex.BlockId)

                        #find the vertex with the current conditional's end statement
                        endVertex = self.findNode('endif:', BB.last_instruction[2])
                        thenNextId = thenVertex.BlockId - 1
                        elseNextId = elseVertex.BlockId - 1

                        if (elseVertex.BlockId == thenNextId):
                            #if block after then block is conditional else add end block to then's adj blocks
                            thenVertex.adjVertices.add(endVertex.BlockId)
                        if (endVertex.BlockId == elseNextId):
                            #if block after else block is conditional end add to else block
                            elseVertex.adjVertices.add(endVertex.BlockId)
                
                if BB.last_instruction[1] == 'endif':
                    thenVertex = self.findNode('then:', BB.last_instruction[2])
                    endVertex = self.findNode('endif:', BB.last_instruction[2])

                    BB.adjVertices.add(thenVertex.BlockId)
                    BB.adjVertices.add(endVertex.BlockId)
                    
                    thenNextId = thenVertex.BlockId - 1

                    if (endVertex.BlockId == thenNextId):
                        thenVertex.adjVertices.add(endVertex.BlockId)

                    
                if BB.last_instruction[1] == 'end':
                    #add the while loop end and loop to its condition statement
                    endVertex = self.findNode('end:', BB.last_instruction[2])
                    loopVertex = self.findNode('Loop:', BB.last_instruction[2])
                    BB.adjVertices.add(endVertex.BlockId)
                    BB.adjVertices.add(loopVertex.BlockId)
            
            if BB.last_instruction[0] == 'jmp':
                #signifies a loop instruction
                if (BB.last_instruction[1] == 'while'):
                    whileVertex = self.findNode('while:', BB.last_instruction[2])
                    BB.adjVertices.add(whileVertex.BlockId)        
    
    #function to join all the liveness of the basic blocks once analysis is done
    def joinAllLiveness(self):
        total_liveness = []
        for vertex in self.vertices:
            correctedLiveness = self.InvertIR(vertex.liveness)
            for live in correctedLiveness:
                total_liveness.insert(0, live)
        return total_liveness
                

    #prints grpah
    def PrintCFG(self):
        output = open("test_output" + str(self.printCount) + ".txt", "w")
        for vertex in self.vertices:
            output.write("Head:" + str(vertex.head))
            output.write('\n')
            output.write(str(vertex.BlockId))
            output.write('\n')
            output.write(str(vertex.adjVertices))
            output.write('\n')
            correctedLiveness = self.InvertIR(vertex.liveness)
            for lst in correctedLiveness:
                output.write(str(lst))
                output.write('\n')
            output.write('\n')
            for command in vertex.instructions:
                output.write(str(command))
                output.write('\n')
            output.write('\n')
        output.close()
    
    #gets the parents of a node for Liveness
    def GetParents(self, NodeId):
        parentsList = []
        for vertex in self.vertices:
            if NodeId in vertex.adjVertices:
                parentsList.append(vertex.BlockId)
        
        return parentsList

    def CheckLiveUp(self, currLiveUp, newLiveUp):
        for var in newLiveUp:
            if var not in currLiveUp:
                return True
        
        #edge case where no variables are live out of a block
        if (len(currLiveUp) == 0) and (len(newLiveUp) == 0):
            return True
        
        return False

    def livenessComplete(self):
        for vertex in self.vertices:
            if (len(vertex.liveness) == 1):
                return False
        
        return True


    #preform liveness on a cfg
    def ControlFlowLiveness(self):
        # create liveness queue
        livenessQueue = []

        #structures to help liveness converge
        #queued holds blocks on which liveness is commplete, headLiveIn holds values live into head
        queued = set()
        headLiveIn = set()

        #find and push first vertex
        firstVertex = self.GetVertexById(0)
        if (firstVertex != None):
            livenessQueue.append(firstVertex.BlockId)

        #while queue not empty do liveness on first block in queue
        while (len(livenessQueue) != 0):
            #get current block and its current up liveness
            currBlockId = livenessQueue.pop(0)
            currBlock = self.GetVertexById(currBlockId)
            currUpLive = currBlock.LiveUp
            livenessProg = self.InvertIR(currBlock.instructions)


            #preform liveness on current block and store it in block 
            newBlockLiveness = liveness_analysis(livenessProg, self.userFuncs, currBlock.liveness[0])

            currBlock.liveness = newBlockLiveness
            currBlock.LiveUp = newBlockLiveness[len(newBlockLiveness)-1]
            newUpLive = currBlock.LiveUp
            # print("Current Block:" + str(currBlock.BlockId))

            #if there are new live variables after analyzing a loop pop parents back into queue
            headBlock = self.GetHead()

            parents = self.GetParents(currBlock.BlockId)
            parents.sort()
            if (currBlock.first_instruction[0] == 'while:'):
                correspondingLoopEnd = self.findNodeByLast('while', currBlock.first_instruction[1])
                if (self.CheckLiveUp(currUpLive, newUpLive)):
                    
                    for i in range(currBlock.BlockId, correspondingLoopEnd.BlockId, -1):
                        if (i in queued):
                            queued.remove(i)

                        if (i in livenessQueue):
                            livenessQueue.remove(i)
                
                    if (correspondingLoopEnd.BlockId in livenessQueue):
                        livenessQueue.remove(correspondingLoopEnd)

                    for var in currBlock.LiveUp:
                        if var not in correspondingLoopEnd.liveness[0]:
                            correspondingLoopEnd.liveness[0].append(var) 

                    livenessQueue.append(correspondingLoopEnd.BlockId)
                else:
                    for parentId in parents:
                        if (parentId != correspondingLoopEnd.BlockId):
                            parent = self.GetVertexById(parentId)

                            if (parentId in livenessQueue):
                                livenessQueue.remove(parentId) 

                            for var in currBlock.LiveUp:
                                if var not in parent.liveness[0]:
                                    parent.liveness[0].append(var)

                            livenessQueue.append(parent.BlockId)

                            queued.add(parentId)
            else:
                for parentId in parents:
                    parent = self.GetVertexById(parentId)
                    parentLiveIn = parent.liveness[0]
                    parentLiveInMismatch = False
                    for var in newUpLive:
                        if var not in parentLiveIn:
                            parentLiveInMismatch = True

                    if (parentId in queued):
                        if (parentLiveInMismatch) or (parentId == headBlock.BlockId):
                            if (parentId in livenessQueue):
                                livenessQueue.remove(parentId)
                            for var in newUpLive:
                                if var not in parent.liveness[0]:
                                    parent.liveness[0].append(var)
                            livenessQueue.append(parentId)
                            if (parentId in queued):
                                queued.remove(parentId)
                            queued.add(parentId)
                    else:
                        for var in newUpLive:
                            if var not in parent.liveness[0]:
                                parent.liveness[0].append(var)
                        livenessQueue.append(parent.BlockId)
                        queued.add(parent.BlockId)
            
            
            if ((len(livenessQueue) == 0) or currBlock.BlockId == headBlock.BlockId) and self.livenessComplete():
                if (len(self.vertices) > 1):
                    for vertex in self.vertices:
                        if (vertex.BlockId != headBlock.BlockId):
                            vertex.liveness.pop(len(vertex.liveness) - 1)
                
                self.totalLiveness = self.joinAllLiveness()
                return self.totalLiveness
                
        
         

