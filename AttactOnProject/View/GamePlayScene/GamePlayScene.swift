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
    var totalSeconds:Int = 300
    let timer = SKLabelNode(fontNamed: "FoxGrotesqueProHeavy")
    var screenText : SKLabelNode!
    let background = SKSpriteNode(imageNamed: "gamePlaySceneBackground")
    let pauseButton = SKSpriteNode(imageNamed: "Pause-Button")
    let notification = NotificationCenter.default
    var currentTodoTask = [TaskCardContainer]()
    var currentOnProgres = [TaskCardContainer]()
    var currentOnReview = [TaskCardContainer]()
    var currentDone = [TaskCardContainer]()
    var allTodoTask = [TaskCardContainer]()
    var playGameplayBGM = AVAudioPlayer()
    var employeeTaskBar = SKSpriteNode()
    let dimPanel = SKSpriteNode(imageNamed: "Plain-Black-Wallpaper")
    let giveUp = SKSpriteNode(imageNamed: "Give-Up")
    let continueButton = SKSpriteNode(imageNamed: "Continue-Button")
    
    override func didMove(to view: SKView) {
        
        print("tesss")
        do{
            playGameplayBGM = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ingame", ofType: "mp3")!))
            playGameplayBGM.prepareToPlay()
        } catch {
            print(error)
        }
        
        playGameplayBGM.play()
        notification.post(name: Notification.Name("StopMusic"), object: nil)
        let testClass = GameRuleCtrl()
        print(testClass.getAllGameRuleData())
        
        self.initBackground()
        self.initToDoCard()
        self.initOnProgressCard(index: 0)
        self.initReviewCard(index: 0)
        self.initDoneCard(index: 0)
        self.initEmployeeCard()
        self.initScoreCard()
        self.detailGameBar()
        self.initPauseButton()
        self.initFadelayer()
        upadateProgressBar()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
    func restartTimer(){
        
        let wait:SKAction = SKAction.wait(forDuration: 1)
        let finishTimer:SKAction = SKAction.run {
            self.totalSeconds -= 1
            
            self.timer.text = "\((self.totalSeconds % 3600) / 60) : \((self.totalSeconds % 3600) % 60)"
            
            self.restartTimer()
        }
        
        let seq:SKAction = SKAction.sequence([wait, finishTimer])
        self.run(seq)
        
        
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
            var nameofTouchedNode = touchedNode.name
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
                 onGoingToDo(name: touchedNode.name!)
           }
            else if (touchedNode.name?.contains("onProgress")  == true){
                
                onGoingOnProgress(name: touchedNode.name!)
                
            }
            else if (touchedNode.name?.contains("onReview") == true) {
                print("a")
                print(currentOnReview.count)
                onGoingReview(name: touchedNode.name!)
            }else if nameofTouchedNode == "pauseButton" as String? {
                if dimPanel.isHidden == true {
                    dimPanel.isHidden = false
                    giveUp.isHidden = false
                    continueButton.isHidden = false
                }
            } else if nameofTouchedNode == "giveUpButton" as String? {
                backToStageScene()
            } else if nameofTouchedNode == "continueButton" as String? {
                dimPanel.isHidden = true
                giveUp.isHidden = true
                continueButton.isHidden = true
            }
                
        }
    }
    
    func backToStageScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = StageScene(size: self.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = AfterGameScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func initGiveUpButton() {
        giveUp.position = CGPoint(x: frame.midX-200, y: frame.midY)
        giveUp.size = CGSize(width: self.size.width/2.5, height: self.size.height/3)
        giveUp.name = "giveUpButton"
        giveUp.zPosition = 101
        addChild(giveUp)
        giveUp.isHidden = true
    }
    
    func initContinueButton() {
        continueButton.position = CGPoint(x: frame.midX+200, y: frame.midY)
        continueButton.size = CGSize(width: self.size.width/2.5, height: self.size.height/3)
        continueButton.name = "continueButton"
        continueButton.zPosition = 101
        addChild(continueButton)
        continueButton.isHidden = true
    }
    func initFadelayer() {
        
        dimPanel.color = UIColor.black
        dimPanel.alpha = 0.75
        dimPanel.zPosition = 100
        dimPanel.position = CGPoint(x: frame.midX, y: frame.midY)
        dimPanel.size = CGSize(width: self.frame.width, height: self.frame.height)
        dimPanel.name = "dimPanel"
        initGiveUpButton()
        initContinueButton()
        self.addChild(dimPanel)
        dimPanel.isHidden = true
    }
    func initTimeBar() {
        let gameBar = SKSpriteNode(imageNamed: "Time-Bar")
        gameBar.size = self.size
        gameBar.position = CGPoint(x: frame.midX, y: frame.maxY)
        gameBar.zPosition = 3
        addChild(gameBar)
    }
    func initPauseButton() {
        pauseButton.name = "pauseButton"
        pauseButton.position = CGPoint(x: frame.minX+45, y: frame.maxY*0.85)
        pauseButton.size = CGSize(width: self.size.width/16, height: self.size.height/8)
        pauseButton.zPosition = 3
        addChild(pauseButton)
    }
    func initBackground() {
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
    
    func onGoingToDo(name: String){

        print("a")
        for n in 0...currentTodoTask.count - 1{
            if currentTodoTask[n].nodeName == name{
                if currentTodoTask[n].progress == 0{
                    if let child = self.childNode(withName: name){
                        child.removeFromParent()
                    }
                    currentOnProgres.append(currentTodoTask[n])
                    currentTodoTask.remove(at: n)
                    initOnProgressCard(index: 1)
                    break
                }

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
                taskMeter.name = "\(n - 1) onProgress"
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
            
        }

    }
    func onGoingOnProgress(name: String){
        
        for n in 0...currentOnProgres.count - 1{
            if currentOnProgres[n].nodeName == name{
                if currentOnProgres[n].progress == 0{
                    if let child = self.childNode(withName: name){
                        child.removeFromParent()
                    }
                    currentOnReview.append(currentOnProgres[n])
                    currentOnProgres.remove(at: n)
                    initReviewCard(index: 1)
                    break
                }
                
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
            let employeeCard = SKSpriteNode(imageNamed: "lock")
            
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
        for n in 1...6 {
            let employeeCard = SKSpriteNode(imageNamed: "lock")
            employeeCard.size = CGSize(width: 55, height: 55)
            employeeCard.name = "employeeCard-\(n)"
            employeeCard.position = CGPoint(x: frame.minX*charSpace, y: frame.minY*0.75)
            addChild(employeeCard)
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
        let detailContainer = SKSpriteNode(color: .black, size: CGSize(width: frame.width/3, height: frame.height/8))
        detailContainer.position = CGPoint(x: frame.midX - 10, y: frame.maxY * 0.85)
        addChild(detailContainer)
        
        let taskLabel = SKLabelNode(text: "5/5")
        taskLabel.fontName =  "FoxGrotesqueProHeavy"
        taskLabel.fontSize = 20
        taskLabel.fontColor = SKColor.white
        taskLabel.position = CGPoint(x: detailContainer.frame.minX + 50, y: detailContainer.frame.midY * 0.96)
        taskLabel.zPosition = 1
        addChild(taskLabel)
        
        
        timer.fontSize = 20
        timer.fontColor = SKColor.white
        timer.position = CGPoint(x: detailContainer.frame.maxX * 0.8, y: detailContainer.frame.midY * 0.96)
        timer.zPosition = 1
        timer.name = "Timer"
        addChild(timer)
        timer.text = "\((totalSeconds % 3600) / 60) : \((totalSeconds % 3600) % 60)"
        restartTimer()
        

        
        let roundSprite = SKSpriteNode(color: .white, size: CGSize(width: 50, height: 50))
        roundSprite.position = CGPoint(x: detailContainer.frame.midX, y: detailContainer.frame.maxY * 0.9)
        roundSprite.zPosition = 1
        addChild(roundSprite)
    }
    func getAllTaskByStage() -> [TaskCardContainer] {
        var allStageTask = [TaskCardContainer]()
        
        for n in 1...5 {
            allStageTask.append(TaskCardContainer(name: "taskkkkkkk \(n)", type: "eng", status: false, progress: 0, nodeName: ""))
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
    
    init(name: String, type: String, status: Bool, progress: Int, nodeName: String) {
        self.name = name
        self.type = type
        self.status = status
        self.progress = progress
        self.nodeName = nodeName
    }
}
