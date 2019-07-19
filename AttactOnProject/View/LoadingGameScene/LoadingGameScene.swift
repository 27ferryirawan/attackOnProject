//
//  LoadingGameScene.swift
//  AttactOnProject
//
//  Created by Hendy Sen on 15/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
class LoadingGameScene: SKScene {
    
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    
    override func didMove(to view: SKView) {
        //next button styling
        nextButton.position = CGPoint(x: frame.maxX*0.9, y: frame.maxY*0.1)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.1, height: nextButton.size.height * 0.1)
        nextButton.zPosition = 2
        addChild(nextButton)
        goToNextLoadingScene()
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
    
    //
        func goToNextLoadingScene(){
            let loadingView = SKScene(size: self.size)
            view?.presentScene(loadingView, transition: SKTransition.fade(withDuration: 1))
            loadingView.backgroundColor = SKColor.black
    
            let circleImage = SKSpriteNode(imageNamed: "Group 626")
            circleImage.position = CGPoint(x: frame.midX, y: frame.midY + 25)
            loadingView.addChild(circleImage)
    
            let factImage = SKSpriteNode(imageNamed: "Group 83")
            factImage.position = CGPoint(x: frame.midX, y: frame.midY/4)
            loadingView.addChild(factImage)
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.goToNextScene()
                self.removeAllChildren()
                
            }
    
        }
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 2)

        let scene:SKScene = FinishGame(size: self.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
        print("a")
    }
}
