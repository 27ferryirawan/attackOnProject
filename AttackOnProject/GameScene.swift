//
//  GameScene.swift
//  AttackOnProject
//
//  Created by Ferry Irawan on 09/07/19.
//  Copyright © 2019 Ferry Irawan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let loadingView = SKSpriteNode(imageNamed: "surprised")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        loadingView.position = CGPoint(x: size.width*0.1, y: size.height*0.5)
        addChild(loadingView)
    
        }
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
