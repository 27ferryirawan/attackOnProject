//
//  KanbanBoardScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 12/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

class KanbanBoardScene: SKScene {
    
    let newScreen = SKSpriteNode(imageNamed: "human")
    
    override func didMove(to view: SKView) {
        addChild(newScreen)
        newScreen.xScale = 0.50
        newScreen.yScale = 0.50
        newScreen.position = CGPoint(x: 0, y: 0)
        
        backgroundColor = UIColor.orange
        //test
    }
}
