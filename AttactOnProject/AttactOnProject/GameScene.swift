//
//  GameScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 12/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let goddess = SKSpriteNode(imageNamed: "human")
    
    override func didMove(to view: SKView) {
        addChild(goddess)
        goddess.xScale = 0.50
        goddess.yScale = 0.50
        goddess.position = CGPoint(x: 0, y: 0)
        
        backgroundColor = UIColor.orange
    }
}
