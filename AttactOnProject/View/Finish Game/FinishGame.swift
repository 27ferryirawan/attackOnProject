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
    //finish game scene
    
    let background = SKSpriteNode(imageNamed: "Project-Finish-View-BG")
    let nextBtn = SKSpriteNode(imageNamed: "next-button")
    let closeBtn = SKSpriteNode(imageNamed: "close-button")
    let midView = SKSpriteNode(imageNamed: "box-stacked")
    
    override func didMove(to view: SKView) {
        //backround sizing and positioning
        background.zPosition = 0
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //midMid styling
        midView.zPosition = 1
        midView.position = CGPoint(x: frame.midX , y: frame.midY+18)
        midView.size = CGSize(width: frame.height*1.05, height: frame.height*1.05-50)
        
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
        
        addChild(background)
        addChild(midView)
        addChild(nextBtn)
        addChild(closeBtn)
    }
    //
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "closeButton" {
                self.goBackToHomeScene()
            }
        }
    }
    
    func goBackToHomeScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = GameScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
}