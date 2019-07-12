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
    let background = SKSpriteNode(imageNamed: "yoona")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
//    let background = SKSpriteNode(imageNamed: "human")
    
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.orange
//        addChild(goddess)
//        goddess.xScale = 0.50
//        goddess.yScale = 0.50
//        goddess.position = CGPoint(x: 0, y: 0)
//        backgroundColor = UIColor.orange
        
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "yoona")
//        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
//        self.view?.insertSubview(backgroundImage, at: 0)
//        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
//        addChild(background)
        background.zPosition = -1
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        nextButton.position = CGPoint(x: size.width/2, y: size.height/2)
        nextButton.name = "nextButton"
        nextButton.size = CGSize(width: nextButton.size.width * 0.2, height: nextButton.size.height * 0.2)
        
        addChild(background)
        addChild(nextButton)
        
//        let nextView = UIView(frame: CGRect(x: self.frame.size.width+88, y: self.frame.size.width/2-20, width: 44, height: 44))
//        let nextBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 44, height: 44)))
//        nextBtn.setImage(UIImage(named: "right-arrow"), for: .normal)
////        nextBtn.addTarget(self, action: #selector(goToNotification), for: .touchUpInside)
//        nextView.addSubview(nextBtn)
//        view.addSubview(nextView)
    }
}
