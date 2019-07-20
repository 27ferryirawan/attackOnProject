//
//  PreGameScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 14/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVKit
import AVFoundation

class PreGameScene: SKScene {
    let background = SKSpriteNode(imageNamed: "gamePlaySceneBackground")
    let nextButton = SKSpriteNode(imageNamed: "start-button")
    let levelPreview = SKSpriteNode(imageNamed: "unused-box")
    let starStage = SKSpriteNode(imageNamed: "Star-Stage")
    let backButton = SKSpriteNode(imageNamed: "closeBtn")
    let SelectTeam = SKSpriteNode(imageNamed: "Select Team")
    let SelectTeam2 = SKSpriteNode(imageNamed: "Select Team 2")
    var screenText : SKLabelNode!
    let impact = UIImpactFeedbackGenerator()
    let GameViewing = GameViewController()
    
    override func didMove(to view: SKView) {
        //backround sizing and positioning
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)

        //Level Preview Sizing and Positioning
        levelPreview.size = CGSize(width: self.size.width*0.7, height: self.size.height*0.7)
        levelPreview.position = CGPoint(x: frame.midX, y: frame.midY)
        levelPreview.zPosition = 3
        
        //Star Sizing and Positioning
        starStage.size = CGSize(width: self.size.width/4, height: self.size.height/3)
        starStage.position = CGPoint(x: frame.midX, y: frame.maxY*0.8)
        starStage.zPosition = 4
        
        //next button styling
        nextButton.position = CGPoint(x: frame.midX, y: frame.minY*0.65)
        nextButton.name = "startButton"
        nextButton.size = CGSize(width: nextButton.size.width*0.4, height: nextButton.size.height*0.4)
        nextButton.zPosition = 4
        
        //close Button Sizing and Styling
        backButton.name = "backButton"
        backButton.position = CGPoint(x: levelPreview.frame.maxX-15, y: levelPreview.frame.maxY-15)
        backButton.zPosition = 4
        
        //Select Team Sizing and Styling
        SelectTeam.size = CGSize(width: self.size.width/11, height: self.size.height/4.2)
        SelectTeam.name = "selectTeam"
        SelectTeam.position = CGPoint(x: levelPreview.frame.midX-188, y: levelPreview.frame.midY-18)
        SelectTeam.zPosition = 4
        
        //Select Team 2 Sizing and Styling
        SelectTeam2.size = CGSize(width: self.size.width/11, height: self.size.height/4.2)
        SelectTeam2.name = "selectTeam"
        SelectTeam2.position = CGPoint(x: levelPreview.frame.midX-93, y: levelPreview.frame.midY-18)
        SelectTeam2.zPosition = 4
        
        addChild(SelectTeam2)
        addChild(SelectTeam)
        addChild(backButton)
        addChild(starStage)
        addChild(levelPreview)
        addChild(nextButton)
        addChild(background)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "startButton" {
                //GameViewController.playBGM
                impact.impactOccurred()
                // Call the function here.
                self.goToNextScene()
            } else if touchedNode.name == "backButton" {
                impact.impactOccurred()
                self.returntoLevelSelect()
            } else if touchedNode.name == "selectTeam" {
                impact.impactOccurred()
                self.selectEmployeeScene()
            }
        }
    }
    
    func goToNextScene() {
        let skView = self.view as SKView?
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = GamePlayScene(size: skView!.bounds.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
        
        //GameViewing.playBGM.pause()
        
    }
    
    func returntoLevelSelect() {
        let skView = self.view as SKView?
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = StageScene(size: skView!.bounds.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func selectEmployeeScene() {
        let skView = self.view as SKView?
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = EmployeeSelectScene(size: skView!.bounds.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
}
