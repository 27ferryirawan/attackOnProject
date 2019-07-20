//
//  UpgradeShopScene.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 14/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit

class UpgradeShopScene: SKScene {
    let background = SKSpriteNode(imageNamed: "upgradeShopBackground")
    let backButton = SKSpriteNode(imageNamed: "close-button")
    let agnes = SKSpriteNode(imageNamed: "Agnes")
    let aurel = SKSpriteNode(imageNamed: "Aurel")
    let clieff = SKSpriteNode(imageNamed: "Clieff")
    let devina = SKSpriteNode(imageNamed: "Devina")
    let pav = SKSpriteNode(imageNamed: "Pav")
    let sen = SKSpriteNode(imageNamed: "Sen")
    let moneyBox = SKSpriteNode(imageNamed: "Money-Box")
    let impact = UIImpactFeedbackGenerator()
    let ClickSoundEffect = SKAction.playSoundFileNamed("Click.mp3", waitForCompletion: false)
    override func didMove(to view: SKView) {
        //backround sizing and positioning
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //Agnes's Styling and Positioning
        agnes.zPosition = 1
        agnes.position = CGPoint(x: frame.maxX*0.585, y: frame.midY*0.88)
        agnes.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        agnes.name = "agnes"
        
        //Aurel's Styling and Positioning
        aurel.zPosition = 1
        aurel.position = CGPoint(x: frame.maxX*0.27, y: frame.midY*0.83)
        aurel.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        aurel.name = "aurel"
        
        //Clieff's Styling and Positioning
        clieff.zPosition = 1
        clieff.position = CGPoint(x: frame.maxX*0.735, y: frame.midY*0.9)
        clieff.size = CGSize(width: self.size.width*0.14, height: self.size.height*0.75)
        clieff.name = "clieff"
        
        //Devina's Styling and Positioning
        devina.zPosition = 1
        devina.position = CGPoint(x: frame.maxX*0.89, y: frame.midY*0.85)
        devina.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        devina.name = "devina"
        
        //Pav's Styling and Positioning
        pav.zPosition = 1
        pav.position = CGPoint(x: frame.maxX*0.425, y: frame.midY*0.92)
        pav.size = CGSize(width: self.size.width*0.1375, height: self.size.height*0.75)
        pav.name = "pav"
        
        //Sen's Styling and Positioning
        sen.zPosition = 1
        sen.position = CGPoint(x: frame.maxX*0.12, y: frame.midY*0.88)
        sen.size = CGSize(width: self.size.width*0.20, height: self.size.height*0.75)
        sen.name = "sen"
        
        //Close button styling
        backButton.position = CGPoint(x: frame.maxX*0.1, y: frame.maxY*0.92)
        backButton.name = "closeButton"
        backButton.size = CGSize(width: backButton.size.width * 0.2, height: backButton.size.height * 0.2)
        
        //Money Box Size and Styling
        moneyBox.size = CGSize(width: self.size.width/6, height: self.size.height/10)
        moneyBox.position = CGPoint(x:frame.maxX*0.85, y:frame.maxY*0.92)
        moneyBox.zPosition = 3
        
        
        addChild(moneyBox)
        addChild(backButton)
        addChild(background)
        addChild(agnes)
        addChild(aurel)
        addChild(clieff)
        addChild(devina)
        addChild(pav)
        addChild(sen)
    }
    
    func goToStageScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = StageScene(size: self.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch : AnyObject in touches{
            let location = touch.location(in: self)
            var touchNode = atPoint(location)
            let nameOfTouch = touchNode.name
            //            if nameOfTouch == "1" {
            //                touchedBoxNode = Int(touchNode.name!)!
            //                print(arrBlueLevelBox[1].position)
            //                arrBlueLevelBox[touchedBoxNode-1].texture = SKTexture(imageNamed: "orangeBlock")
            //           } else
            if nameOfTouch == "closeButton" {
                backButton.run(SKAction.sequence([
                    ClickSoundEffect,
                    SKAction.run(goToStageScene)
                    ]))
                impact.impactOccurred()
                
            } else if nameOfTouch == "agnes" {
                
            }
            
            
        }
    }
}
