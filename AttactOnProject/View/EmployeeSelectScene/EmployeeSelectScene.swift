//
//  EmployeeSelectScene.swift
//  AttactOnProject
//
//  Created by Clieff Tyhonksky on 20/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

import AVFoundation
import AVKit

class EmployeeSelectScene: SKScene {
    let impact = UIImpactFeedbackGenerator()
    let background = SKSpriteNode(imageNamed: "gamePlaySceneBackground")
    let employeeSelect = SKSpriteNode(imageNamed: "Team-Box-Idle")
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.self.width, height: frame.self.height)
        background.zPosition = 0
        addChild(background)
        
        employeeSelect.position = CGPoint(x: frame.midX, y: frame.midY)
        employeeSelect.size = CGSize(width: self.size.width-150, height: self.size.height+30)
        employeeSelect.zPosition = 1
        addChild(employeeSelect)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "nextButton" {
                // Call the function here.
                
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
