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
    let impact = UIImpactFeedbackGenerator()
    
    override func didMove(to view: SKView) {
        //backround sizing and positioning
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //Agnes's Styling and Positioning
        agnes.zPosition = 1
        agnes.position = CGPoint(x: frame.maxX*0.55, y: frame.midY)
        agnes.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        
        //Aurel's Styling and Positioning
        aurel.zPosition = 1
        aurel.position = CGPoint(x: frame.maxX*0.25, y: frame.midY)
        aurel.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        
        //Clieff's Styling and Positioning
        clieff.zPosition = 1
        clieff.position = CGPoint(x: frame.maxX*0.7, y: frame.midY)
        clieff.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        
        //Devina's Styling and Positioning
        devina.zPosition = 1
        devina.position = CGPoint(x: frame.maxX*0.85, y: frame.midY)
        devina.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        
        //Pav's Styling and Positioning
        pav.zPosition = 1
        pav.position = CGPoint(x: frame.maxX*0.4, y: frame.midY)
        pav.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        
        //Sen's Styling and Positioning
        sen.zPosition = 1
        sen.position = CGPoint(x: frame.maxX*0.1, y: frame.midY)
        sen.size = CGSize(width: self.size.width*0.15, height: self.size.height*0.75)
        
        //next button styling
        backButton.position = CGPoint(x: frame.maxX*0.2, y: frame.maxY*0.1)
        backButton.name = "closeButton"
        backButton.size = CGSize(width: backButton.size.width * 0.3, height: backButton.size.height * 0.3)
    
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
            impact.impactOccurred()
            
            goToStageScene()
            }
            
            
        }
    }
}
