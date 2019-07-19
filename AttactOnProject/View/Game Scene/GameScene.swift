//
//  GameScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 12/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "yoona")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    let loadingContainer = SKSpriteNode(imageNamed: "amit-jain-1477751-unsplash")
    let loadingBar = UIProgressView(progressViewStyle: .bar)
    
    override func didMove(to view: SKView) {
        //background styling
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //next button styling
        nextButton.position = CGPoint(x: frame.maxX*0.9, y: frame.maxY*0.1)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.1, height: nextButton.size.height * 0.1)
        
        
        loadingContainer.position = CGPoint(x: frame.midX, y: frame.midY/2)
        loadingContainer.size = CGSize(width: frame.width*3/4, height: frame.height/2 - 50)
        addChild(background)
        addChild(loadingContainer)
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

//        let transition:SKTransition = SKTransition.fade(withDuration: 1)
//        let scene:SKScene = GamePlayScene(size: self.size)
        let transition:SKTransition = SKTransition.fade(withDuration: 2)
        let scene:SKScene = TutorialSceneOne(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        print("a")
    }
}

