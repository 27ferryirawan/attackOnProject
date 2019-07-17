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
    override func didMove(to view: SKView) {
        //backround sizing and positioning
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //screen text styling
        screenText = SKLabelNode(fontNamed: "Arial")
        screenText.text = "This is Gameplay Screen Scene"
        screenText.fontSize = 40
        screenText.position = CGPoint(x: frame.midX, y: frame.midY)
        
        //next button styling
        nextButton.position = CGPoint(x: frame.maxX*0.9, y: frame.maxY*0.1)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.1, height: nextButton.size.height * 0.1)
        
        addChild(screenText)
        addChild(nextButton)
        addChild(background)
    }
    
    var currentScore:Int = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "nextButton" {
                // Call the function here.
                self.goToNextScene()
            }
        }
    }
    
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = AfterGameScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func initBackground() {
        //backround sizing and positioning
        
        let background = SKSpriteNode(imageNamed: "gamePlaySceneBackground")
        background.zPosition = -2
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        addChild(background)
    }
    
    func initToDoCard() {
        let todoMainCard = SKSpriteNode(imageNamed: "Kanban-01-todo-blank")
        
        todoMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
        todoMainCard.name = "todoMainCard"
        todoMainCard.position = CGPoint(x: frame.minX*0.7, y: frame.maxY*0.1)
        todoMainCard.zPosition = -1
        
        for n in 1...4 {
            let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
            let employeeCard = SKSpriteNode(imageNamed: "lock")
            
            employeeCard.size = CGSize(width: 55, height: 55)
            employeeCard.name = "employeeCardToDo-\(n)"
            
            taskContainer.alpha = 0.5
            
            if(n==1) {
                taskContainer.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*0.3)
                employeeCard.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*0.3)
            }
            
            if(n==2) {
                taskContainer.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*0.3)
                employeeCard.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*0.3)
            }
            
            if(n==3) {
                taskContainer.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*(-0.15))
                employeeCard.position = CGPoint(x: frame.minX*0.79, y: frame.maxY*(-0.15))
            }
            
            if(n==4) {
                taskContainer.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*(-0.15))
                employeeCard.position = CGPoint(x: frame.minX*0.61, y: frame.maxY*(-0.15))
            }
            
            addChild(employeeCard)
            addChild(taskContainer)
        }
        addChild(todoMainCard)
    }
    
    func initOnProgressCard() {
        let onProgressMainCard = SKSpriteNode(imageNamed: "Kanban-02-onprogress-blank")
        
        onProgressMainCard.size = CGSize(width: frame.width*0.2, height: frame.height*0.6)
        onProgressMainCard.name = "onProgressMainCard"
        onProgressMainCard.position = CGPoint(x: frame.minX*0.25, y: frame.maxY*0.1)
        onProgressMainCard.zPosition = -1
        
        for n in 1...4 {
            let taskContainer = SKSpriteNode(color: UIColor.black, size: CGSize(width: 79, height: 79))
            let employeeCard = SKSpriteNode(imageNamed: "lock")
            
            taskContainer.alpha = 0.5
            employeeCard.size = CGSize(width: 55, height: 55)
            employeeCard.name = "employeeCardProgress-\(n)"
            
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
            let employeeCard = SKSpriteNode(imageNamed: "lock")
            
            taskContainer.alpha = 0.5
            employeeCard.size = CGSize(width: 55, height: 55)
            employeeCard.name = "employeeCardReview-\(n)"
            
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
}

class TaskCardContainer {
    var name: String
    var type: String
    var status: Bool
    
    init(name: String, type: String, status: Bool) {
        self.name = name
        self.type = type
        self.status = status
    }
}
