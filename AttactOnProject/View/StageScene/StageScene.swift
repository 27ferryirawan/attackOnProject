import SpriteKit
import GameplayKit

class StageScene: SKScene {
    let background = SKSpriteNode(imageNamed: "stageSceneBackground")
    let upgradeButton = SKSpriteNode(imageNamed: "Upgrade-Button")
    let containerBox = SKSpriteNode(imageNamed: "containerBox")
    var screenText : SKLabelNode!
    var arrBlueLevelBox: [SKSpriteNode] = [SKSpriteNode]()
    var imageName = "blueBlock"
    var starImageName = ""
    var blueLevelBox = SKSpriteNode()
    var touchedBoxNode = -1
    var starArr : [Int] = [3,2,1,0,3,0,0,0,0,0,0,0,0,0,0]
    let impact = UIImpactFeedbackGenerator()
    var userMoney = 0
    var userScore = [Int](repeating: 0, count: 15)
    var employeeList = [EmployeeContainer]()
    
    
    override func didMove(to view: SKView) {
        print(self.size)
        //backround sizing and positioning
        self.initUserDefaultData()
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
        upgradeButton.position = CGPoint(x: frame.maxX*0.8, y: frame.minY*0.25)
        upgradeButton.name = "upgradeButton"
        upgradeButton.size = CGSize(width: upgradeButton.size.width * 0.5, height: upgradeButton.size.height * 0.5)
        
        //addChild(screenText)
        addChild(upgradeButton)
        addChild(background)
        containerLevelSelect()
        moneyBox()
    }
    
    func initUserDefaultData() {
        if(!self.checkUserDefaultKey(key: "userMoney")) {
            UserDefaults.standard.set(0, forKey: "userMoney")
            userMoney = 0
        } else{
            userMoney = UserDefaults.standard.integer(forKey: "userMoney")
        }
        
        if(!self.checkUserDefaultKey(key: "userScore1")) {
            for n in 1...15 {
                UserDefaults.standard.set(0, forKey: "userScore\(n)")
                userScore.append(0)
            }
        } else {
            for n in 1...15 {
                userScore[n-1] = UserDefaults.standard.integer(forKey: "userScore\(n)")
            }
        }
        
        if(!self.checkUserDefaultKey(key: "employeeList")) {
            var tempEmployeeList = [EmployeeContainer]()
            tempEmployeeList.append(EmployeeContainer(name: "Nizar", speed: 10, maksTask: 2, type: "SE"))
            tempEmployeeList.append(EmployeeContainer(name: "Jasmine", speed: 8, maksTask: 1, type: "QA"))
            employeeList.append(EmployeeContainer(name: "Nizar", speed: 10, maksTask: 2, type: "SE"))
            employeeList.append(EmployeeContainer(name: "Jasmine", speed: 8, maksTask: 1, type: "QA"))
            
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: tempEmployeeList, requiringSecureCoding: false)
                UserDefaults.standard.set(data, forKey: "employeeList")
            } catch {
                print("Couldn't write file")
            }
        } else {
            do {
                let undecodedEmployeeData = UserDefaults.standard.object(forKey: "employeeList")
                let decodedArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(undecodedEmployeeData as! Data) as! [EmployeeContainer]
                print(decodedArray)
            } catch {
                print("Couldn't read file.")
            }
        }
    }
    
    func checkUserDefaultKey(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
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
        for touch : AnyObject in touches{
            let location = touch.location(in: self)
            var touchNode = atPoint(location)
            let nameOfTouch = touchNode.name
            //var numberArr : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
            if nameOfTouch == "1" {
                impact.impactOccurred()
                touchedBoxNode = Int(touchNode.name!)!
                print(arrBlueLevelBox[1].position)
                arrBlueLevelBox[touchedBoxNode-1].texture = SKTexture(imageNamed: "orangeBlock")
            } else if nameOfTouch == "upgradeButton" {
                impact.impactOccurred()
                goToUpgradeScene()
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let touchNode = atPoint(location)
            if touchNode.name != nil && touchedBoxNode != -1{
                self.arrBlueLevelBox[self.touchedBoxNode-1].texture = SKTexture(imageNamed: "blueBlock")
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
//        for touch in touches {
//            let location = touch.location(in: self)
//            let touchedNode = atPoint(location)
//            if touchedNode.name != nil && touchedBoxNode != -1 {
//                goToNextScene()
//                self.arrBlueLevelBox[self.touchedBoxNode-1].texture = SKTexture(imageNamed: "blueBlock")
//                self.touchedBoxNode = -1
//            }
//            if touchedBoxNode != -1 {
//                self.arrBlueLevelBox[self.touchedBoxNode-1].texture = SKTexture(imageNamed: "blueBlock")
//                self.touchedBoxNode = -1
//            }
//        super.touchesEnded(touches, with: event)
//
//        }
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            
            if touchedNode.name != nil && touchedBoxNode != -1 {
                goToNextScene()
                self.arrBlueLevelBox[self.touchedBoxNode-1].texture = SKTexture(imageNamed: "blueBlock")
                self.touchedBoxNode = -1
                
                
            }
            
        }
    }
    
    
    
    func goToNextScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = PreGameScene(size: self.size)
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func goToUpgradeScene() {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene:SKScene = UpgradeShopScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
    }
}

class EmployeeContainer: NSObject, NSCoding {
    let name:String!
    let speed:Int!
    let type:String!
    let maksTask:Int!
    
    init(name: String, speed: Int, maksTask: Int, type:String) {
        self.name = name
        self.speed = speed
        self.maksTask = maksTask
        self.type = type
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String else { return nil }
        guard let speed = decoder.decodeObject(forKey: "speed") as? Int else { return nil }
        guard let type = decoder.decodeObject(forKey: "type") as? String else { return nil }
        guard let maksTask = decoder.decodeObject(forKey: "maksTask") as? Int else { return nil }
        
        self.init(name: name, speed: speed, maksTask: maksTask, type: type)
    }
    
    // Here you need to set properties to specific keys in archive
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.speed, forKey: "speed")
        aCoder.encode(self.type, forKey: "type")
        aCoder.encode(self.maksTask, forKey: "maksTask")
    }
}
