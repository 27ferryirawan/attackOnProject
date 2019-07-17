//
//  TutorialSceneOne.swift
//  AttactOnProject
//
//  Created by Ferry Irawan on 17/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

class TutorialSceneOne: SKScene {
    
    let background = SKSpriteNode(imageNamed: "Project-Finish-View-BG")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    let tappedButton = SKSpriteNode(color: .clear, size: CGSize(width: 90, height: 115))
    let totalMoneyBox = SKSpriteNode(imageNamed: "moneymoneymakeyousmile")
    let teamBoxStateOne = SKSpriteNode(imageNamed: "Team-Box-Idle")
    let teamBoxStateTwo = SKSpriteNode(imageNamed: "Team-Box-Active")
    
    var totalMoneyText : SKLabelNode!
    
    override func didMove(to view: SKView) {
        displayBckg()
        displayTotalMoney()
        displayStateOne()
        displayStateTwo()
        displayTappedBtn()
    }
    
    func displayTappedBtn(){
        tappedButton.zPosition = 2
        tappedButton.position = CGPoint(x: frame.midX-105, y: frame.midY-78)
        tappedButton.name = "tappedButton"
        addChild(tappedButton)
    }
    func displayBckg(){
        //backround sizing and positioning
        background.zPosition = 0
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        addChild(background)
    }
    func displayTotalMoney(){
        //total money box styling
        totalMoneyBox.zPosition = 2
        totalMoneyBox.position = CGPoint(x: background.frame.maxX - 125, y: background.frame.maxY - 25)
        totalMoneyBox.zPosition = 2
        
        //totalmoney Completion Text  styling
        totalMoneyText = SKLabelNode(fontNamed: "Arial")
        totalMoneyText.text = "200.000.000"
        totalMoneyText.fontSize = 17
        totalMoneyText.fontColor = .white
        totalMoneyText.position = CGPoint(x: background.frame.maxX - 112, y: background.frame.maxY - 30)
        totalMoneyText.zPosition = 3
        
        addChild(totalMoneyText)
        addChild(totalMoneyBox)
    }
    func displayStateOne(){
        teamBoxStateOne.zPosition = 1
        teamBoxStateOne.size = CGSize(width: frame.height*1.4, height: frame.height*1.25-50)
        teamBoxStateOne.position = CGPoint(x: frame.midX-(frame.width/2)/9, y: frame.midY)
        addChild(teamBoxStateOne)
    }
    
    func displayStateTwo(){
        teamBoxStateTwo.zPosition = 2
        teamBoxStateTwo.size = CGSize(width: frame.height*1.4, height: frame.height*1.25-50)
        teamBoxStateTwo.position = CGPoint(x: frame.midX-(frame.width/2)/9, y: frame.midY)
//        addChild(teamBoxStateTwo)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "nextButton" {
                // Call the function here.
                self.goToNextScene()
            } else if touchedNode.name == "tappedButton" {
                // Call the function here.
                self.goToStateTwo()
            }
        }
    }
    
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = GamePlayScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func goToStateTwo() {
        print("asdasd")
        addChild(teamBoxStateTwo)
    }
}

