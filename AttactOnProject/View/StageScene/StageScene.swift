import SpriteKit
import GameplayKit

class StageScene: SKScene {
    let background = SKSpriteNode(imageNamed: "stageSceneBackground")
    let nextButton = SKSpriteNode(imageNamed: "right-arrow")
    let containerBox = SKSpriteNode(imageNamed: "containerBox")
    var screenText : SKLabelNode!
    var arrBlueLevelBox: [SKSpriteNode] = [SKSpriteNode]()
    var imageName = "blueBlock"
    var starImageName = ""
    var blueLevelBox = SKSpriteNode()
    var touchedBoxNode = -1
    var starArr : [Int] = [3,2,1,0,3,0,0,0,0,0,0,0,0,0,0]
    override func didMove(to view: SKView) {
        print(self.size)
        //backround sizing and positioning
        background.zPosition = -1
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = CGSize(width: frame.width, height: frame.height)
        print(self.size)
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
        
        containerBox.position = CGPoint(x: background.frame.midX, y: background.frame.midY)
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
        
        for i in 1...3 {
            posX = i-1
            for z in 0...4{
                if i == 2{
                    imageName = "lockBlock"
                }
                blueLevelBox = SKSpriteNode(imageNamed: imageName)
                
                blueLevelBox.position = CGPoint(x: containerBox.frame.minX  + CGFloat(80 + (97 * z)), y: containerBox.frame.midY + CGFloat(65 - (85 * posX)))
                blueLevelBox.name = "\(numberLevel)"
                blueLevelBox.zPosition = 2
                arrBlueLevelBox.append(blueLevelBox)
                containerBox.addChild(blueLevelBox)
                
                if i == 1{
                    let blueLevelLabel = SKLabelNode(text: "\(numberLevel)")
                    blueLevelLabel.fontName = "FoxGrotesqueProHeavy"
                    blueLevelLabel.fontSize = 40
                    blueLevelLabel.position = CGPoint(x: blueLevelBox.frame.midX  , y: blueLevelBox.frame.minY + 13)
                    blueLevelLabel.zPosition = 3
                    blueLevelLabel.name = blueLevelBox.name
                    addChild(blueLevelLabel)
                    starImageName = "\(starArr[numberLevel-1])Star"
                    let levelStar = SKSpriteNode(imageNamed: starImageName)
                    levelStar.position = CGPoint(x: blueLevelBox.frame.midX
                        , y: blueLevelBox.frame.minY - 15)
                    levelStar.zPosition = 2
                    addChild(levelStar)
                }
                else {
                    let levelStar = SKSpriteNode(imageNamed: "0Star")
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
        
        
        let totalMoneyText = SKLabelNode(fontNamed: "FoxGrotesqueProHeavy")
        totalMoneyText.text = "200.000.000"
        totalMoneyText.fontSize = 15
        totalMoneyText.fontColor = .white
        totalMoneyText.position = CGPoint(x: background.frame.maxX - 112, y: background.frame.maxY - 30)
        totalMoneyText.zPosition = 3
        addChild(totalMoneyText)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for touch in touches{
////            let location = touch.location(in: self)
////            let touchNode = atPoint(location)
////
////            if touchNode.name != nil{
////                touchedBoxNode = Int(touchNode.name!)!
////                print(arrBlueLevelBox[1].position)
////                arrBlueLevelBox[touchedBoxNode-1].texture = SKTexture(imageNamed: "orangeBlock")
////            }
////
////
////        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            if touchNode.name == "closeButton"
            {
                containerBox.removeAllChildren()
                //self.removeChildren(in: containerBox)
            }
            else if touchNode.name != nil{
                touchedBoxNode = Int(touchNode.name!)!
                print(arrBlueLevelBox[1].position)
                arrBlueLevelBox[touchedBoxNode-1].texture = SKTexture(imageNamed: "orangeBlock")
            }
            

        }
        super.touchesBegan(touches, with: event)
    }
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches{
//            let location = touch.location(in: self)
//            let touchNode = atPoint(location)
//            if touchNode.name != nil && touchedBoxNode != -1{
//
//
//                    self.arrBlueLevelBox[self.touchedBoxNode-1].texture = SKTexture(imageNamed: "blueBlock")
//
//
//
//            }
//
//        }
////
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            if touchedBoxNode != -1 {
                    goToNextScene()
                    self.arrBlueLevelBox[self.touchedBoxNode-1].texture = SKTexture(imageNamed: "blueBlock")
                    self.touchedBoxNode = -1
            }
            
        }

        super.touchesEnded(touches, with: event)
    }
    
    
    
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = GamePlayScene(size: self.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
    
}

