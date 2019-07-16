//
//  KanbanBoardScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 12/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

class StageScene: SKScene {
    let background = SKSpriteNode(imageNamed: "stageSceneBackground")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    var screenText : SKLabelNode!
    
    override func didMove(to view: SKView) {
        //backround sizing and positioning
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //screen text styling
        screenText = SKLabelNode(fontNamed: "Arial")
        screenText.text = "This is Stage Screen Scene"
        screenText.fontSize = 40
        screenText.position = CGPoint(x: frame.midX, y: frame.midY)
        
        //next button styling
        nextButton.position = CGPoint(x: frame.maxX*0.9, y: frame.maxY*0.1)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.1, height: nextButton.size.height * 0.1)
        
        //addChild(screenText)
        addChild(nextButton)
        addChild(background)
        containerLevelSelect()
        moneyBox()
    }
    
    func containerLevelSelect() {
        let containerBox = SKSpriteNode(imageNamed: "containerBox")
        containerBox.position = CGPoint(x: frame.midX, y: frame.midY)
        containerBox.zPosition = 0
        addChild(containerBox)
        
        let closeButton = SKSpriteNode(imageNamed: "closeBtn")
        closeButton.position = CGPoint(x: containerBox.frame
            .maxX - 10, y: containerBox.frame.maxY - 40)
        closeButton.name = "closeButton"
        closeButton.zPosition = 1
        containerBox.addChild(closeButton)
        
        
        //Level Block
        var posX = 0
        var numberLevel = 1
        var imageName = "blueBlock"
        for i in 1...3 {
            posX = i-1
            for z in 0...4{
                if i == 2{
                    imageName = "lockBlock"
                }
                let blueLevelBox = SKSpriteNode(imageNamed: imageName)
                blueLevelBox.position = CGPoint(x: containerBox.frame.minX + CGFloat(80 + (97 * z)), y: containerBox.frame.midY + CGFloat(65 - (85 * posX)))
                blueLevelBox.name = "\(numberLevel)"
                blueLevelBox.zPosition = 2
                containerBox.addChild(blueLevelBox)
                
                if i == 1{
                    let blueLevelLabel = SKLabelNode(text: "\(numberLevel)")
                    blueLevelLabel.fontName = "FoxGrotesqueProHeavy"
                    blueLevelLabel.fontSize = 40
                    blueLevelLabel.position = CGPoint(x: blueLevelBox.frame.midX, y: blueLevelBox.frame.minY + 13)
                    blueLevelLabel.zPosition = 3
                    blueLevelLabel.name = blueLevelBox.name
                    addChild(blueLevelLabel)
                    
                    let levelStar = SKSpriteNode(imageNamed: "3star")
                    levelStar.position = CGPoint(x: blueLevelBox.frame.midX
                        , y: blueLevelBox.frame.minY - 15)
                    levelStar.zPosition = 2
                    addChild(levelStar)
                }
                else {
                    let levelStar = SKSpriteNode(imageNamed: "noStar")
                    levelStar.position = CGPoint(x: blueLevelBox.frame.midX
                        , y: blueLevelBox.frame.minY - 15)
                    levelStar.zPosition = 2
                    addChild(levelStar)
                }
                

                numberLevel += 1
            }
            
        }
        
        

        
        
    }
    
    func moneyBox() {
        let moneyContainer = SKSpriteNode(imageNamed: "moneymoneymakeyousmile")
        moneyContainer.position = CGPoint(x: background.frame.maxX - 125, y: background.frame.maxY - 25)
        moneyContainer.zPosition = 2
        background.addChild(moneyContainer)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            
//            touchNode.name = SKSpriteNode(
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            var name = 0
            if touchedNode.name != nil {
                name = Int(touchedNode.name!)!
            }
            if name != nil && name != 0{
                // Call the function here.
                print(name)
              //  self.goToNextScene()
            }
        }
    }
    
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = PreGameScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
}
