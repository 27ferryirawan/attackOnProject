//
//  GamePlayScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 14/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit
import AVFoundation

class GamePlayScene: SKScene {
    let background = SKSpriteNode(imageNamed: "gamePlaySceneBackground")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    var screenText : SKLabelNode!

    let notification = NotificationCenter.default

    var employeeCharacter = [EmployeeContainer]()
    var currentTodoTask = [TaskCardContainer]()
    var currentOnProgres = [TaskCardContainer]()
    var currentOnReview = [TaskCardContainer]()
    var currentDone = [TaskCardContainer]()
    var allTodoTask = [TaskCardContainer]()
    var playGameplayBGM = AVAudioPlayer()
    
    var employeeTaskBar = SKSpriteNode()
    var selectedTask = SKSpriteNode()
    var selectedTaskBool  =  false
    var selectedIndex = -1
    var nizarTask = 0
    var jasmineTask = 0
    var clickedNodeName = ""
    var lastClickedNode =  ""
    override func didMove(to view: SKView) {

        do{
            playGameplayBGM = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ingame", ofType: "mp3")!))
            playGameplayBGM.prepareToPlay()
        } catch {
            print(error)
        }
        
        playGameplayBGM.play()
        notification.post(name: Notification.Name("StopMusic"), object: nil)
        let testClass = GameRuleCtrl()
       // print(testClass.getAllGameRuleData())
        getEmployee()
        self.initBackground()
        self.initToDoCard()
        self.initOnProgressCard(index: 0)
        self.initReviewCard(index: 0)
        self.initDoneCard(index: 0)
        self.initEmployeeCard()
        self.initScoreCard()
        self.detailGameBar()
        upadateProgressBar()
        
    }
    
    func getEmployee () {
        
        do {
            let undecodedEmployeeData = UserDefaults.standard.object(forKey: "employeeList")
            let decodedArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(undecodedEmployeeData as! Data) as! [EmployeeContainer]
            for n in decodedArray {
            employeeCharacter.append(n)
                
            }
            
            print(decodedArray)
        } catch {
            print("Couldn't read file.")
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
    func upadateProgressBar(){
//        if currentTodoTask.count != 0 {
//            for i in  0...currentTodoTask.count - 1   {
//                if currentTodoTask[i].progress <= 3{
//                    currentTodoTask[i].progress =  0
//                    print(currentTodoTask[i].progress)
//                }
//            }
//            initToDoCard(index: 1)
//        }
    }
    var currentScore:Int = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            print(touchedNode.name)
            print(currentOnReview.count)
            if (touchedNode.name?.contains("toDo") == true){
                //let indexed: Int? = Int(touchedNode.name!.prefix(1))
//                if currentTodoTask[todoCount-indexed!].progress == 0 {
//                    currentOnProgres.append(currentTodoTask[indexed! - todoCount])
//                    currentTodoTask.remove(at: indexed! - todoCount)
//                    self.initOnProgressCard()
//                    //self.initToDoCard()
//                    //todocount di kurangkan jika task bertambah
//                    if let child = self.childNode(withName: touchedNode.name!) {
//
//                        child.removeFromParent()
//                    }
//                }
                clickedNodeName = touchedNode.name!
                selectedToDo(name: touchedNode.name!)
                onGoingToDo()
           }
            else if (touchedNode.name?.contains("onProgress")  == true){
                
                clickedNodeName = touchedNode.name!
                selectedOnProgress(name: clickedNodeName)
                onGoingOnProgress()
                
            }
            else if (touchedNode.name?.contains("onReview") == true) {
                print("a")
                print(currentOnReview.count)
                onGoingReview(name: touchedNode.name!)
            }
            else if(touchedNode.name?.contains("employeeCard") == true){
                print(lastClickedNode)

                if lastClickedNode.contains("toDo"){
                    assignedToDo(name: touchedNode.name!)
                    onGoingToDo()
                }
                else if lastClickedNode.contains("onProgress"){
                    assignedOnProgress(name: touchedNode.name!)
                    onGoingOnProgress()
                }

                
            }

                
        }
    }
    
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = AfterGameScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func initBackground() {
        let background = SKSpriteNode(imageNamed: "gamePlaySceneBackground")
        background.zPosition = -2
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        addChild(background)
    }
    
    func initToDoCard() {
            allTodoTask = self.getAllTaskByStage()
            //        print(allTodoTask)
            if currentTodoTask.count <= 4 {
                for n in allTodoTask {
                    print(n.name)
                    if currentTodoTask.count == 4{
                        break
                    }
                    currentTodoTask.append(n)
                    allTodoTask.removeFirst()
                }
            }
            
            
            let todoMainCard = SKSpriteNode(imageNamed: "Kanban-01-todo-blank")
            
            todoMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
            todoMainCard.name = "todoMainCard"
            todoMainCard.position = CGPoint(x: frame.minX*0.7, y: frame.maxY*0.1)
            todoMainCard.zPosition = -1
            
            for n in 1...currentTodoTask.count {
                    
                let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
                taskContainer.alpha = 0.5
                    
                employeeTaskBar = SKSpriteNode(imageNamed: "Task-Meter-\(currentTodoTask[n-1].progress + 1)")
                employeeTaskBar.size = CGSize(width: 60, height: 15)
                employeeTaskBar.name = "\(n) toDo"
                currentTodoTask[n-1].nodeName = employeeTaskBar.name!
                employeeTaskBar.zPosition =  2
                    
                let employeeTaskLabel = SKLabelNode(text: currentTodoTask[n-1].name)
                employeeTaskLabel.name = "\(n)"
                employeeTaskLabel.fontName = "FoxGrotesqueProHeavy"
                employeeTaskLabel.fontSize = 13
                employeeTaskLabel.position = CGPoint(x: taskContainer.frame.midX, y: taskContainer.frame.maxY * 0.55)
                employeeTaskLabel.zPosition = 1
                employeeTaskLabel.name = "\(n) toDo"
                    //employeeTaskLabel.lineBreakMode = NSLineBreakMode.
                employeeTaskLabel.preferredMaxLayoutWidth = taskContainer.frame.width
                //employeeTaskLabel.horizontalAlignmentMode = .center
                employeeTaskLabel.verticalAlignmentMode = .center
                    //employeeTaskLabel.alig
                employeeTaskLabel.numberOfLines = 0
                    
                if(n==1) {
                    taskContainer.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*0.3)
                    employeeTaskBar.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*0.3)
                }
                    
                if(n==2) {
                    taskContainer.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*0.3)
                    employeeTaskBar.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*0.3)
                }
                    
                if(n==3) {
                    taskContainer.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*(-0.15))
                    employeeTaskBar.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*(-0.15))
                }
                    
                if(n==4) {
                    taskContainer.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*(-0.15))
                    employeeTaskBar.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*(-0.15))
                }
                    
                addChild(employeeTaskBar)
                addChild(taskContainer)
                employeeTaskBar.addChild(employeeTaskLabel)
            }
            addChild(todoMainCard)
    }
    
    func findingToDoTask(name: String) -> Int{
        for n in 0...currentTodoTask.count-1 {
            if currentTodoTask[n].nodeName == name{
                return  n
            }
        }
        return  0
    }
    
    func onGoingToDo(){
        print("assign",currentTodoTask[selectedIndex].assign)
        print("selected",currentTodoTask[selectedIndex].selected)
        
        for n in 0...currentTodoTask.count - 1{
            if currentTodoTask[n].nodeName == clickedNodeName{
                print("a")
                if currentTodoTask[n].assign == true  && currentTodoTask[n].selected == true{
                    
                    if currentTodoTask[n].progress == 0{
                        if let child = self.childNode(withName: clickedNodeName){
                            child.removeFromParent()
                        }
                        currentTodoTask[n].assign = false
                        currentTodoTask[n].selected = false
                        currentOnProgres.append(currentTodoTask[n])
                        currentTodoTask.remove(at: n)
                        initOnProgressCard(index: 1)
                        selectedTaskBool = false
                        selectedTask.removeFromParent()
                       // print(currentOnProgres[n].assign)
                        break
                        
                    }
                }


            }
        }

    }

    func selectedToDo(name: String){
        let temp = findingToDoTask(name: name)
        selectedIndex = temp
        if selectedTaskBool == true {
            currentTodoTask[selectedIndex].selected  = true
            selectedTask.removeFromParent()
        }
        else {
            print("a")
            currentTodoTask[selectedIndex].selected = true
            selectedTaskBool = true
        }
        
        selectedTask = SKSpriteNode(color: .orange, size: CGSize(width: 79, height: 79))
        
        if(Int(name.prefix(1))==1) {
            selectedTask.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*0.3)
            
        }
            
        else if(Int(name.prefix(1))==2) {
            selectedTask.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*0.3)
        }
            
        else if(Int(name.prefix(1))==3) {
            selectedTask.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*(-0.15))
            
        }
            
        else if(Int(name.prefix(1))==4) {
            selectedTask.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*(-0.15))
        }
        lastClickedNode = name
        selectedTask.zPosition = 1
        selectedTask.alpha = 1
        addChild(selectedTask)
        

    }
    func assignedToDo(name: String){

        if selectedIndex != -1 {
            if currentTodoTask[selectedIndex].selected == true{
                print(currentTodoTask[selectedIndex].assign)
                print(currentTodoTask[selectedIndex].selected)
                currentTodoTask[selectedIndex].assign = true
            }

            currentTodoTask[selectedIndex].employeeName = name
            if name.contains("Nizar"){
                nizarTask += 1
            }
            else{
                jasmineTask += 1
            }
            
        }
    }
    func initOnProgressCard(index: Int) {
        if index == 0 {
            
            let onProgressMainCard = SKSpriteNode(imageNamed: "Kanban-02-onprogress-blank")
            
            onProgressMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
            onProgressMainCard.name = "onProgressMainCard"
            onProgressMainCard.position = CGPoint(x: frame.minX*0.25, y: frame.maxY*0.1)
            onProgressMainCard.zPosition = -1
            addChild(onProgressMainCard)
        }
        
        if currentOnProgres.count != 0 {
            let n = currentOnProgres.count
                let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
                let taskMeter = SKSpriteNode(imageNamed: "Task-Meter-\(1)")
                
                taskContainer.alpha = 0.5
                taskMeter.size = CGSize(width: 60, height: 15)
                taskMeter.name = "\(n) onProgress"
                taskMeter.zPosition = 2
                currentOnProgres[n - 1].nodeName = taskMeter.name!
            
            
                let employeeTaskLabel = SKLabelNode(text: currentOnProgres[n - 1].name)
                employeeTaskLabel.fontName = "FoxGrotesqueProHeavy"
                employeeTaskLabel.fontSize = 13
                employeeTaskLabel.position = CGPoint(x: taskContainer.frame.midX, y: taskContainer.frame.maxY * 0.55)
                employeeTaskLabel.zPosition = 1
                //employeeTaskLabel.lineBreakMode = NSLineBreakMode.
                employeeTaskLabel.preferredMaxLayoutWidth = taskContainer.frame.width
                //employeeTaskLabel.horizontalAlignmentMode = .center
                employeeTaskLabel.verticalAlignmentMode = .center
                //employeeTaskLabel.alig
                employeeTaskLabel.numberOfLines = 0
                print(currentOnProgres[n-1].employeeName)
                let smallCharImg = SKSpriteNode(imageNamed: "\(currentOnProgres[n - 1].employeeName) Small")
                smallCharImg.size = CGSize(width: 30, height: 40)
                smallCharImg.position = CGPoint(x: taskMeter.frame.midX, y: taskMeter.frame.minY - 15)
            smallCharImg.zPosition = 1

                if(n==1) {
                    taskContainer.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*0.3)
                    taskMeter.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*0.3)
                }
                
                if(n==2) {
                    taskContainer.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*0.3)
                    taskMeter.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*0.3)
                }
                
                if(n==3) {
                    taskContainer.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*(-0.15))
                    taskMeter.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*(-0.15))
                }
                
                if(n==4) {
                    taskContainer.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*(-0.15))
                    taskMeter.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*(-0.15))
                }
                
                addChild(taskMeter)
                addChild(taskContainer)
                taskMeter.addChild(employeeTaskLabel)
                taskMeter.addChild(smallCharImg)

        }

    }
    func findingOnProgressTask(name: String) -> Int{
        for n in 0...currentOnProgres.count-1 {
            if currentOnProgres[n].nodeName == name{
                return  n
            }
        }
        return  0
    }
    
    func onGoingOnProgress(){
        
        for n in 0...currentOnProgres.count - 1{
            if currentOnProgres[n].nodeName == clickedNodeName{
                if currentOnProgres[n].progress == 0 && currentOnProgres[n].assign ==  true &&  currentOnProgres[n].selected == true{
                    if let child = self.childNode(withName: clickedNodeName){
                        child.removeFromParent()
                    }
                    currentOnProgres[n].assign = false
                    currentOnProgres[n].selected = false
                currentOnReview.append(currentOnProgres[n])
                    currentOnProgres.remove(at: n)
                    initReviewCard(index: 1)
                    selectedTaskBool = false
                    selectedTask.removeFromParent()
                    break
                }
                
            }
        }
        
    }
    func selectedOnProgress(name: String){
        let temp = findingOnProgressTask(name: name)
        selectedIndex = temp
        if selectedTaskBool == true {
            currentOnProgres[selectedIndex].selected  = true
            selectedTask.removeFromParent()
        }
        else {
            print("a")
            currentOnProgres[selectedIndex].selected = true
            selectedTaskBool = true
        }

        selectedTask = SKSpriteNode(color: .orange, size: CGSize(width: 79, height: 79))
        
        if(Int(name.prefix(1))==1) {
            selectedTask.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*0.3)
            
        }
            
        else if(Int(name.prefix(1))==2) {
            selectedTask.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*0.3)
        }
            
        else if(Int(name.prefix(1))==3) {
            selectedTask.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*(-0.15))
            
        }
            
        else if(Int(name.prefix(1))==4) {
            selectedTask.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*(-0.15))
        }
        lastClickedNode = name
        selectedTask.zPosition = 1
        selectedTask.alpha = 1
        addChild(selectedTask)
    
    }
    func assignedOnProgress(name: String){
        
        if selectedIndex != -1 {
            if currentOnProgres[selectedIndex].selected == true {
            currentOnProgres[selectedIndex].assign = true
            }
            currentOnProgres[selectedIndex].employeeName = name
            if name.contains("Nizar"){
                nizarTask += 1
            }
            else{
                jasmineTask += 1
            }
            
        }
    }
    func initReviewCard(index: Int) {
        if index == 0{
            let reviewMainCard = SKSpriteNode(imageNamed: "Kanban-03-review-blank")
            
            reviewMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
            reviewMainCard.name = "onProgressMainCard"
            reviewMainCard.position = CGPoint(x: frame.maxX*0.2, y: frame.maxY*0.1)
            reviewMainCard.zPosition = -1
            addChild(reviewMainCard)
        }
        
        if currentOnReview.count != 0 {
            let n = currentOnReview.count
            let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
            let taskMeter = SKSpriteNode(imageNamed: "Task-Meter-\(1)")
            
            taskContainer.alpha = 0.5
            taskMeter.size = CGSize(width: 60, height: 15)
            taskMeter.name = "\(n) onReview"
            currentOnReview[n - 1].nodeName = taskMeter.name!
            taskMeter.zPosition = 2
            let employeeTaskLabel = SKLabelNode(text: currentOnReview[n-1].name)
            employeeTaskLabel.fontName = "FoxGrotesqueProHeavy"
            employeeTaskLabel.fontSize = 13
            employeeTaskLabel.position = CGPoint(x: taskContainer.frame.midX, y: taskContainer.frame.maxY * 0.55)
            employeeTaskLabel.zPosition = 1
            //employeeTaskLabel.lineBreakMode = NSLineBreakMode.
            employeeTaskLabel.preferredMaxLayoutWidth = taskContainer.frame.width
            //employeeTaskLabel.horizontalAlignmentMode = .center
            employeeTaskLabel.verticalAlignmentMode = .center
            //employeeTaskLabel.alig
            employeeTaskLabel.numberOfLines = 0
            let smallCharImg = SKSpriteNode(imageNamed: "\(currentOnReview[n - 1].employeeName) Small")
            smallCharImg.size = CGSize(width: 30, height: 40)
            smallCharImg.position = CGPoint(x: taskMeter.frame.midX, y: taskMeter.frame.minY - 15)
            smallCharImg.zPosition = 1

            
            if(n==1) {
                taskContainer.position = CGPoint(x: frame.maxX*0.11, y: frame.maxY*0.3)
                taskMeter.position = CGPoint(x: frame.maxX*0.11, y: frame.maxY*0.3)
            }
            
            if(n==2) {
                taskContainer.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*0.3)
                taskMeter.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*0.3)
            }
            
            if(n==3) {
                taskContainer.position = CGPoint(x: frame.maxX*0.11, y: frame.maxY*(-0.15))
                taskMeter.position = CGPoint(x: frame.maxX*0.11, y: frame.maxY*(-0.15))
            }
            
            if(n==4) {
                taskContainer.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*(-0.15))
                taskMeter.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*(-0.15))
            }
            
            addChild(taskMeter)
            addChild(taskContainer)
            taskMeter.addChild(employeeTaskLabel)
            taskMeter.addChild(smallCharImg)
        }
       
    }
    func onGoingReview(name: String){
        
        for n in 0...currentOnReview.count - 1{
            if currentOnReview[n].nodeName == name{
                if currentOnReview[n].progress == 0{
                    if let child = self.childNode(withName: name){
                        child.removeFromParent()
                    }
                    currentDone.append(currentOnReview[n])
                    currentOnReview.remove(at: n)
                    initDoneCard(index: 1)
                    break
                }
                
            }
        }
    }
    
    func initDoneCard(index: Int) {
        if index == 0{
            
            let doneMainCard = SKSpriteNode(imageNamed: "Kanban-04-done-blank")
            
            doneMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
            doneMainCard.name = "onProgressMainCard"
            doneMainCard.position = CGPoint(x: frame.maxX*0.65, y: frame.maxY*0.1)
            doneMainCard.zPosition = -1
            addChild(doneMainCard)
        }
       
        if currentDone.count != 0 {
            
            let n =  currentDone.count
            let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
            let employeeCard = SKSpriteNode(imageNamed: "Done-Mark")
            
            taskContainer.alpha = 0.5
            employeeCard.size = CGSize(width: 55, height: 55)
            employeeCard.name = "employeeCardDone-\(n - 1)"
            
            if(n==1) {
                taskContainer.position = CGPoint(x: frame.maxX*0.56, y: frame.maxY*0.3)
                employeeCard.position = CGPoint(x: frame.maxX*0.56, y: frame.maxY*0.3)
            }
            
            if(n==2) {
                taskContainer.position = CGPoint(x: frame.maxX*0.74, y: frame.maxY*0.3)
                employeeCard.position = CGPoint(x: frame.maxX*0.74, y: frame.maxY*0.3)
            }
            
            if(n==3) {
                taskContainer.position = CGPoint(x: frame.maxX*0.56, y: frame.maxY*(-0.15))
                employeeCard.position = CGPoint(x: frame.maxX*0.56, y: frame.maxY*(-0.15))
            }
            
            if(n==4) {
                taskContainer.position = CGPoint(x: frame.maxX*0.74, y: frame.maxY*(-0.15))
                employeeCard.position = CGPoint(x: frame.maxX*0.74, y: frame.maxY*(-0.15))
            }
            
            addChild(employeeCard)
            addChild(taskContainer)
        }
        
       
        
    }
    
    func initEmployeeCard() {
        let characterBoard = SKSpriteNode(imageNamed: "Character-Board")
        characterBoard.name = "characterBoard"
        characterBoard.position = CGPoint(x: frame.midX, y: frame.minY*0.75)
        characterBoard.size = CGSize(width: frame.width*0.8, height: frame.height*0.2)
        characterBoard.zPosition = -1
        addChild(characterBoard)
        

        var charSpace:CGFloat = 0.65
        for n in 1...employeeCharacter.count {
            let employeeCard = SKSpriteNode(imageNamed: "\(employeeCharacter[n-1].name!)")
            employeeCard.size = CGSize(width: 100, height: 100)
            employeeCard.name = "\(employeeCharacter[n-1].name!) employeeCard"
            employeeCard.position = CGPoint(x: frame.minX*charSpace, y: frame.minY*0.75)
            addChild(employeeCard)
//            let characterName = SKLabelNode(text: "\(employeeCharacter[n-1].name!)")
//            characterName.fontName = "FoxGrotesqueProHeavy"
//            characterName.position = CGPoint(x: frame.minX*charSpace, y: frame.minY*0.75)
//            characterName.fontSize = 15
//            addChild(characterName)
            charSpace-=0.25
            
        }
    }
    
    func initScoreCard() {
        let scoreCard = SKSpriteNode(imageNamed: "Money-Box")
        let scoreLabel = SKLabelNode(fontNamed: "FoxGrotesqueProHeavy")
        
        scoreCard.name = "scoreCard"
        scoreCard.size = CGSize(width: frame.width*0.16, height: frame.height*0.1)
        scoreCard.position = CGPoint(x: frame.maxX*0.65, y: frame.maxY*0.85)
        scoreCard.zPosition = -1
        
        scoreLabel.text = String(0)
        scoreLabel.fontSize = 18
        scoreLabel.position = CGPoint(x: scoreCard.frame.midX + 13, y: scoreCard.frame.midY - 7)
        scoreLabel.zPosition = 2
        addChild(scoreCard)
        addChild(scoreLabel)
    }
    
    func detailGameBar() {
        let detailContainer = SKSpriteNode(imageNamed: "Time-Bar")
        detailContainer.size = CGSize(width: frame.width/3, height: frame.height/8)
        detailContainer.position = CGPoint(x: frame.midX - 10, y: frame.maxY * 0.87)
        addChild(detailContainer)
        
        let taskLabel = SKLabelNode(text: "5/5")
        taskLabel.fontName =  "FoxGrotesqueProHeavy"
        taskLabel.fontSize = 20
        taskLabel.fontColor = SKColor.white
        taskLabel.position = CGPoint(x: detailContainer.frame.minX + 80, y: detailContainer.frame.midY )
        taskLabel.zPosition = 1
        addChild(taskLabel)
        
        let timeLabel =  SKLabelNode(text: "4:59")
        timeLabel.fontName = "FoxGrotesqueProHeavy"
        timeLabel.fontSize = 20
        timeLabel.fontColor =  SKColor.white
        timeLabel.position = CGPoint(x: detailContainer.frame.maxX * 0.7, y: detailContainer.frame.midY)
        timeLabel.zPosition = 1
        addChild(timeLabel)
        
    }
    func getAllTaskByStage() -> [TaskCardContainer] {
        var allStageTask = [TaskCardContainer]()
        
        for n in 1...5 {
            allStageTask.append(TaskCardContainer(name: "taskkkkkkk \(n)", type: "eng", status: false, progress: 0, nodeName: "",  selected: false, assign: false, employeeName: "", image: SKSpriteNode(imageNamed: "")))
        }
        
        return allStageTask
    }
}

class TaskCardContainer {
    var name: String
    var type: String
    var nodeName: String
    var status: Bool
    var progress: Int
    var selected: Bool
    var assign: Bool
    var employeeName: String
    var image: SKSpriteNode
    
    init(name: String, type: String, status: Bool, progress: Int, nodeName: String, selected: Bool, assign: Bool, employeeName: String, image: SKSpriteNode) {
        self.name = name
        self.type = type
        self.status = status
        self.progress = progress
        self.nodeName = nodeName
        self.selected = selected
        self.assign = selected
        self.employeeName = employeeName
        self.image = image
    }
}
