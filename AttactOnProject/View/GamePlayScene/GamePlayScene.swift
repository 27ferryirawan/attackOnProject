//
//  GamePlayScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 14/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

class GamePlayScene: SKScene {
    let background = SKSpriteNode(imageNamed: "gamePlaySceneBackground")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    var screenText : SKLabelNode!
    var todoCount = 0
    var onProgressMakeCount = 0
    var onReviewCount = 0
    var doneCount = 0
    
    
    var currentTodoTask = [TaskCardContainer]()
    var currentOnProgres = [TaskCardContainer]()
    var currentOnReview = [TaskCardContainer]()
    var currentDone = [TaskCardContainer]()
    var allTodoTask = [TaskCardContainer]()
    var employeeTaskBar = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.initBackground()
        self.initToDoCard()
        self.initOnProgressCard()
        self.initReviewCard()
        self.initDoneCard()
        self.initEmployeeCard()
        self.initScoreCard()
        upadateProgressBar()
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
            if (touchedNode.name?.contains("toDo") == true){
                //                let strTemp = String(touchedNode.name!)
                //                let intTemp: Int = Int(strTemp[0])
                
                let indexed: Int? = Int(touchedNode.name!.prefix(1))
                debugPrint("\(indexed ?? 0)")
                if currentTodoTask[indexed!-1].progress == 0 {
                    currentOnProgres.append(currentTodoTask[indexed! - 1])
                    currentTodoTask.remove(at: indexed! - 1)
                    self.initOnProgressCard()
                    //self.initToDoCard()
                    if let child = self.childNode(withName: touchedNode.name!) {
                        
                        child.removeFromParent()
                    }
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
                employeeTaskBar.zPosition =  2
                    
                let employeeTaskLabel = SKLabelNode(text: currentTodoTask[n-1].name)
                employeeTaskLabel.name = "\(n)"
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
                    //taskContainer.addChild(employeeTaskLabel)
            }
            addChild(todoMainCard)
    }
    
    func initOnProgressCard() {
        let onProgressMainCard = SKSpriteNode(imageNamed: "Kanban-02-onprogress-blank")
        
        onProgressMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
        onProgressMainCard.name = "onProgressMainCard"
        onProgressMainCard.position = CGPoint(x: frame.minX*0.25, y: frame.maxY*0.1)
        onProgressMainCard.zPosition = -1
        
        if currentOnProgres.count != 0 {
            for n in 1...currentOnProgres.count {
                let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
                let employeeCard = SKSpriteNode(imageNamed: "Task-Meter-\(n)")
                
                taskContainer.alpha = 0.5
                employeeCard.size = CGSize(width: 60, height: 15)
                employeeCard.name = "employeeCardProgress-\(n)"
                
                let employeeTaskLabel = SKLabelNode(text: currentOnProgres[n-1].name)
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
                    employeeCard.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*0.3)
                }
                
                if(n==2) {
                    taskContainer.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*0.3)
                    employeeCard.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*0.3)
                }
                
                if(n==3) {
                    taskContainer.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*(-0.15))
                    employeeCard.position = CGPoint(x: frame.minX*0.34, y: frame.maxY*(-0.15))
                }
                
                if(n==4) {
                    taskContainer.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*(-0.15))
                    employeeCard.position = CGPoint(x: frame.minX*0.16, y: frame.maxY*(-0.15))
                }
                
                addChild(employeeCard)
                addChild(taskContainer)
                taskContainer.addChild(employeeTaskLabel)
            }
            
        }
        addChild(onProgressMainCard)
    }
    
    func initReviewCard() {
        let reviewMainCard = SKSpriteNode(imageNamed: "Kanban-03-review-blank")
        
        reviewMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
        reviewMainCard.name = "onProgressMainCard"
        reviewMainCard.position = CGPoint(x: frame.maxX*0.2, y: frame.maxY*0.1)
        reviewMainCard.zPosition = -1
        
        for n in 1...4 {
            let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
            let employeeCard = SKSpriteNode(imageNamed: "Task-Meter-\(currentTodoTask[n-1].progress + 1 )")
            
            taskContainer.alpha = 0.5
            employeeCard.size = CGSize(width: 60, height: 15)
            employeeCard.name = "employeeCardReview-\(n)"
            
            let employeeTaskLabel = SKLabelNode(text: currentTodoTask[n-1].name)
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
                employeeCard.position = CGPoint(x: frame.maxX*0.11, y: frame.maxY*0.3)
            }
            
            if(n==2) {
                taskContainer.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*0.3)
                employeeCard.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*0.3)
            }
            
            if(n==3) {
                taskContainer.position = CGPoint(x: frame.maxX*0.11, y: frame.maxY*(-0.15))
                employeeCard.position = CGPoint(x: frame.maxX*0.11, y: frame.maxY*(-0.15))
            }
            
            if(n==4) {
                taskContainer.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*(-0.15))
                employeeCard.position = CGPoint(x: frame.maxX*0.29, y: frame.maxY*(-0.15))
            }
            
            addChild(employeeCard)
            addChild(taskContainer)
            taskContainer.addChild(employeeTaskLabel)
        }
        addChild(reviewMainCard)
    }
    
    func initDoneCard() {
        let doneMainCard = SKSpriteNode(imageNamed: "Kanban-04-done-blank")
        
        doneMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
        doneMainCard.name = "onProgressMainCard"
        doneMainCard.position = CGPoint(x: frame.maxX*0.65, y: frame.maxY*0.1)
        doneMainCard.zPosition = -1
        
        for n in 1...4 {
            let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
            let employeeCard = SKSpriteNode(imageNamed: "lock")
            
            taskContainer.alpha = 0.5
            employeeCard.size = CGSize(width: 55, height: 55)
            employeeCard.name = "employeeCardDone-\(n)"
            
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
        
        addChild(doneMainCard)
        
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
        let scoreLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        
        scoreCard.name = "scoreCard"
        scoreCard.size = CGSize(width: frame.width*0.25, height: frame.height*0.1)
        scoreCard.position = CGPoint(x: frame.maxX*0.55, y: frame.maxY*0.85)
        scoreCard.zPosition = -1
        
        scoreLabel.text = String(currentScore)
        scoreLabel.fontSize = 20
        scoreLabel.position = CGPoint(x: frame.maxX*0.6, y: frame.maxY*0.82)
        
        addChild(scoreCard)
        addChild(scoreLabel)
    }
    
    func getAllTaskByStage() -> [TaskCardContainer] {
        var allStageTask = [TaskCardContainer]()
        
        for n in 1...5 {
            allStageTask.append(TaskCardContainer(name: "taskkkkkkk \(n)", type: "eng", status: false, progress: 0))
        }
        
        return allStageTask
    }
}

class TaskCardContainer {
    var name: String
    var type: String
    var status: Bool
    var progress: Int
    
    init(name: String, type: String, status: Bool, progress: Int) {
        self.name = name
        self.type = type
        self.status = status
        self.progress = progress
    }
}
