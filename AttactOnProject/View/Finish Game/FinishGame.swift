//
//  FinishGame.swift
//  AttactOnProject
//
//  Created by Ferry Irawan on 15/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit


class FinishGame: SKScene {
    //finish game scene asd
    
    let background = SKSpriteNode(imageNamed: "Project-Finish-View-BG")
    let nextBtn = SKSpriteNode(imageNamed: "next-button")
    let closeBtn = SKSpriteNode(imageNamed: "close-button")
    let midView = SKSpriteNode(imageNamed: "box-stacked")
    let totalMoneyBox = SKSpriteNode(imageNamed: "moneymoneymakeyousmile")
    
    var energyText : SKLabelNode!
    var totalMoneyText : SKLabelNode!
    var moneyCompletionText : SKLabelNode!
    
    
    //gray areaUIColor(displayP3Red: 102/255, green: 102/255, blue: 102/255, alpha: 0.8)
    
    override func didMove(to view: SKView) {
        displayBckg()
        displayMidView()
        displayNextCloseBtn()
        displayEnergy()
        displayMoneyCompletion()
        displayTotalMoney()
    }
    
    func displayEnergy(){
        //totalmoney Completion Text  styling
        energyText = SKLabelNode(fontNamed: "FoxGrotesqueProHeavy")
        energyText.text = "5/5"
        energyText.fontSize = 21
        energyText.fontColor = .white
        energyText.position = CGPoint(x: midView.frame.midX+8, y: midView.frame.midY+midView.frame.height/25-0.5)
        energyText.zPosition = 2
        
        addChild(energyText)
    }
    
    func displayMidView(){
        //midMid styling
        midView.zPosition = 1
        midView.position = CGPoint(x: frame.midX-8 , y: frame.midY+24)
        midView.size = CGSize(width: frame.height*1.25, height: frame.height*1.15-50)
        
        addChild(midView)
    }
    
    func displayTotalMoney(){
        //total money box styling
        totalMoneyBox.zPosition = 2
        totalMoneyBox.position = CGPoint(x: background.frame.maxX - 125, y: background.frame.maxY - 25)
        totalMoneyBox.zPosition = 2
        
        //totalmoney Completion Text  styling
        totalMoneyText = SKLabelNode(fontNamed: "FoxGrotesqueProHeavy")
        totalMoneyText.text = "200.000.000"
        totalMoneyText.fontSize = 15
        totalMoneyText.fontColor = .white
        totalMoneyText.position = CGPoint(x: background.frame.maxX - 112, y: background.frame.maxY - 30)
        totalMoneyText.zPosition = 3
        
        addChild(totalMoneyText)
        addChild(totalMoneyBox)
    }
    func displayBckg(){
        //backround sizing and positioning
        background.zPosition = 0
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        addChild(background)
    }
    func displayNextCloseBtn(){
        //close button styling
        closeBtn.zPosition = 2
        closeBtn.size = CGSize(width: midView.frame.width/2-40, height: midView.frame.height/5)
        closeBtn.position = CGPoint(x: midView.frame.midX-midView.frame.width/5+4, y: midView.frame.minY+closeBtn.frame.height/4)
        closeBtn.name = "closeButton"
        

        //next button styling
        nextBtn.zPosition = 2
        nextBtn.size = CGSize(width: midView.frame.width/2-40, height: midView.frame.height/5)
        nextBtn.position = CGPoint(x: midView.frame.midX+midView.frame.width/5+4, y: midView.frame.minY+nextBtn.frame.height/4)
        nextBtn.name = "nextButton"
        
        addChild(nextBtn)
        addChild(closeBtn)
    }
    
    func displayMoneyCompletion(){
        //money Completion Text  styling
        moneyCompletionText = SKLabelNode(fontNamed: "FoxGrotesqueProHeavy")
        moneyCompletionText.text = "+50.000"
        moneyCompletionText.fontSize = 40
        moneyCompletionText.fontColor = .white
        moneyCompletionText.position = CGPoint(x: frame.midX, y: midView.frame.midY-midView.frame.height/4-10)
        moneyCompletionText.zPosition = 2
        
        addChild(moneyCompletionText)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "nextButton" {
//                self.goToNextScene()
            }
        }
    }
    
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = TutorialSceneOne(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
    
    
}
