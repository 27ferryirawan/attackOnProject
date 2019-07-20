//
//  GameScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 12/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

import AVFoundation
import AVKit

class GameScene: SKScene {
    let background = SKSpriteNode(imageNamed: "Title")
    let nextButton = SKSpriteNode(imageNamed: "start-button")
    let impact = UIImpactFeedbackGenerator()
    let ClickSoundEffect = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false)
    override func didMove(to view: SKView) {
        //background styling
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //next button styling
        nextButton.position = CGPoint(x: frame.maxX/2, y: frame.maxY*0.25)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.4, height: nextButton.size.height * 0.4)
        nextButton.zPosition = 1
        addChild(background)
        addChild(nextButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "nextButton" {
                // Call the function here.
                nextButton.run(SKAction.sequence([
                    ClickSoundEffect,
                    SKAction.run(goToNextScene)
                    ]))
                impact.impactOccurred()
                self.goToNextScene()

                }
            }
        }
   
    func goToNextScene() {
        
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = LoadingGameScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        print("a")
    }
}

