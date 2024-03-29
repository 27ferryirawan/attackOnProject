//
//  GameViewController.swift
//  AttactOnProject
//
//  Created by Ahmad Nizar on 12/07/19.
//  Copyright © 2019 Ahmad Nizar. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVKit
import AVFoundation

class GameViewController: UIViewController {
    var playBGM = AVAudioPlayer()
    let audioSession = AVAudioSession()
    let ncObserver = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ncObserver.addObserver(self, selector: #selector(self.stopBgm), name: Notification.Name("StopMusic"), object: nil)

        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
//        if let scene = GKScene(fileNamed: "GamePlayScene") {
//        do{
//            playBGM = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Main Menu AoP", ofType: "mp3")!))
//            playBGM.prepareToPlay()
//        } catch {
//            print(error)
//        }
//        playBGM.play()
        if let scene = GKScene(fileNamed: "LoadingScene") {
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! LoadingScene? {
                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    do{
                        playBGM = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Main Menu AoP", ofType: "mp3")!))
                        playBGM.prepareToPlay()
                    } catch {
                        print(error)
                    }
                    
                    playBGM.play()
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
//                    view.showsFPS = true
//                    view.showsNodeCount = true
                
                }
            }
        }
    }
    
    @objc func stopBgm(){
        playBGM.stop()
    }
    func configureAudioSession() {
        do {
            try audioSession.overrideOutputAudioPort(.speaker)
            try audioSession.setActive(true)
        } catch {
            print("Error")
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
