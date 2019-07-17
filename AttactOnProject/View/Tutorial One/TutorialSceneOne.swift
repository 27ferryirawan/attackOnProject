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
    
    let background = SKSpriteNode(imageNamed: "Team-Detail-View-Blank")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    let tappedButton = SKView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func didMove(to view: SKView) {
        //background styling
        background.zPosition = 0
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //next button styling
        nextButton.position = CGPoint(x: frame.maxX*0.9, y: frame.maxY*0.1)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.1, height: nextButton.size.height * 0.1)
        
        addChild(background)
        addChild(nextButton)
    }
    
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
        let scene:SKScene = GamePlayScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
}

