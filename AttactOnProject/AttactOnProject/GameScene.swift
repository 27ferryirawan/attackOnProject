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
//        addChild(goddess)
//        goddess.xScale = 0.50
//        goddess.yScale = 0.50
//        goddess.position = CGPoint(x: 0, y: 0)
//        backgroundColor = UIColor.orange
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "yoona")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view?.insertSubview(backgroundImage, at: 0)
        
        let nextView = UIView(frame: CGRect(x: self.frame.size.width+88, y: self.frame.size.width/2-20, width: 44, height: 44))
        let nextBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 44, height: 44)))
        nextBtn.setImage(UIImage(named: "right-arrow"), for: .normal)
//        nextBtn.addTarget(self, action: #selector(goToNotification), for: .touchUpInside)
        nextView.addSubview(nextBtn)
        view.addSubview(nextView)
    }
}
