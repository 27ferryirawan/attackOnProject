//
//  PreGameScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 14/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

class PreGameScene: SKScene {
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
        screenText.text = "This is PreGame Screen Scene"
        screenText.fontSize = 40
        screenText.position = CGPoint(x: frame.midX, y: frame.midY)
        
        //next button styling
        nextButton.position = CGPoint(x: frame.maxX*0.9, y: frame.minY*0.8)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.1, height: nextButton.size.height * 0.1)
        
        addChild(screenText)
        addChild(nextButton)
        addChild(background)
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
        let skView = self.view as SKView?
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = GamePlayScene(size: skView!.bounds.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
}
