//
//  LoadingScene.swift
//  AttactOnProject
//
//  Created by Hendy Sen on 15/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
class LoadingScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "Fanch Developer Team")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    let loadingContainer = SKSpriteNode(color: .clear, size: CGSize(width: 0, height: 0))
    let loadingBar = UIProgressView(progressViewStyle: .bar)
    
    override func didMove(to view: SKView) {
        //background styling
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        
        //next button styling
        loadingContainer.position = CGPoint(x: frame.midX, y: frame.midY/2 - 100)
        loadingContainer.size = CGSize(width: frame.width*3/4, height: frame.height/2 - 50)
        addChild(background)

        nextButton.position = CGPoint(x: frame.maxX*0.9, y: frame.maxY*0.1 - 150 )
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.1, height: nextButton.size.height * 0.1)
        
        
//        loadingContainer.position = CGPoint(x: frame.midX, y: frame.midY/2 - 100)
////        loadingContainer.size = CGSize(width: frame.width*3/4, height: frame.height/2 - 50)
        
        addChild(loadingContainer)
//        addChild(nextButton)

        loadingBarEdit()
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
    
    
    func loadingBarEdit(){
        

        loadingBar.frame = CGRect(x: loadingContainer.frame.maxX/2 + 100, y: loadingContainer.frame.maxY + 350, width: loadingContainer.frame.width/2, height: 1)
        loadingBar.progressTintColor = .black

//        loadingBar.frame = CGRect(x: frame.maxX/2, y: frame.midY + 350, width: frame.width/2 , height: 1)
//        loadingBar.progressTintColor = .white

        loadingBar.setProgress(0.1, animated: true)
        loadingBar.transform = loadingBar.transform.scaledBy(x: 1, y: 5)
        loadingBar.layer.zPosition = 2
        view?.addSubview(loadingBar)
        
        UIView.animate(withDuration: 5, delay: 3, animations: {
            self.loadingBar.setProgress(1, animated: true)
        }) { (finished:Bool) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                
                self.goToNextScene()
                self.loadingBar.removeFromSuperview()
                self.background.removeFromParent()
                //self.loadingContainer.removeFromParent()
            }
            
        }
        
    }
    

    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 2)
        let scene:SKScene = GameScene(size: self.frame.size)
        self.view?.presentScene(scene, transition: transition)
        print("a")
    }
}

