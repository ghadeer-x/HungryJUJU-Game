//
//  GameScene.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import GameKit



class GameScene:MainScene, SKPhysicsContactDelegate{
    
    enum mode {
        case single
        case multiplayer
    }

    // initialization
    let GameMode:mode
    var initialState:AnyClass
    
    //Acceleration
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    // for update
    var deltaTime:TimeInterval = 0
    var lastUpdateInterval:TimeInterval = 0
    
    // Achievements
    var noOfCollisions = 0
    
    // multiplayer
    var networkingEngine: MultiplayerNetworking?
    var currentIndex: Int?
    
    var score = 0
    let gameSceneWorld = SKNode()
    let foodNodes = SKNode()
    var playerArr = [Player]()
    
    // ParallaxEffect
    var scrollingForeground:ParallaxSprite!
   
    // GameOverStateCard
    let scoreCard = GButton(
        texture: GameScenePreloads.preload.scoreCard,
        position: EndImg.position.scoreCard,
        zPosition: Layer.ui.rawValue)
    
    // Labels
    var scoreLabel = SimpleLabel(text: "0", fontSize: GLabels.size, Color: GLabels.color, position: GLabels.position.scoreLabel, zPosition: Layer.label.rawValue )
    
    var scoreLabel2 = SimpleLabel(text: "0", fontSize: GLabels.size, Color: GLabels.color, position: GLabels.position.scoreLabel, zPosition: Layer.label.rawValue )
    
    var bestScore = SimpleLabel(text: "0", fontSize: GLabels.size, Color: GLabels.color, position: GLabels.position.bestScore, zPosition: Layer.label.rawValue )
    
    var lastScore = SimpleLabel(text: "0", fontSize: GLabels.size, Color: GLabels.color, position: CGPoint.zero, zPosition: Layer.label.rawValue )
    
    var bestScoreText = SimpleLabel(text: "الأفضل", fontSize: GLabels.size, Color: GLabels.color, position: GLabels.position.bestScore, zPosition: Layer.label.rawValue )
    
    var lastScoreText = SimpleLabel(text: "حاليا", fontSize: GLabels.size, Color: GLabels.color, position: CGPoint.zero, zPosition: Layer.label.rawValue )
    
    
    // Buttons
    let replayButton = GButton(
    texture: GameScenePreloads.preload.replayButton,
    position: EndImg.position.replayButton,
    zPosition: Layer.ui.rawValue)
    
    let shareButton = GButton(
        texture:  GameScenePreloads.preload.shareButton,
        position: EndImg.position.shareButton,
        zPosition: Layer.ui.rawValue)
    
    let homeButton = GButton(
        texture:  GameScenePreloads.preload.homeButton,
        position: EndImg.position.homeButton,
        zPosition: Layer.ui.rawValue)
    

    // GameStates
    lazy var gameState:GKStateMachine = GKStateMachine(
        states:[
            SingleState(scene:self),
            PlayingState(scene:self),
            GameoverState(scene:self)
            //MultiplayerState(scene:self)
        ])
    
    
    init(size:CGSize, stateClass: AnyClass , mode:mode , delegate:GameSceneDelegate!  ){
        initialState = stateClass
        GameMode = mode
        super.init(size: size)
        
        if let gamedelegate = delegate {
            gameSceneDelegate = gamedelegate
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemnted")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        addChild(gameSceneWorld)
        gameSceneWorld.addChild(foodNodes)
        GameScenePhysicsWorld()
        setupForground()
        setupAccelerometer()
        gameState.enter(initialState)
        
    }
    
    func setupAccelerometer(){
        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
    }
    
    func stopFalling(){
        removeAction(forKey: "fall")
        for node in foodNodes.children{
            node.removeAllActions()
        }
    }
    
    override func didSimulatePhysics() {
        for index in 0..<playerArr.count{
        playerArr[index].movementComponent.applyMovement(sceneSize: size.width , xAcc: xAcceleration)
        }
    }
    
    override func update( _ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if lastUpdateInterval == 0 {
            lastUpdateInterval = currentTime
        }
        
        deltaTime = currentTime - lastUpdateInterval
        lastUpdateInterval = currentTime
        gameState.update(deltaTime: deltaTime)
        
        // Per Entity updates
        for index in 0..<playerArr.count{
            playerArr[index].update(deltaTime: deltaTime)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if replayButton.contains(location) {
                replayButton.touchDown()
            }
            if homeButton.contains(location) {
                homeButton.touchDown()
            }
            if shareButton.contains(location) {
                shareButton.touchDown()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            replayButton.touchUp()
            homeButton.touchUp()
            shareButton.touchUp()
  
            
            if replayButton.contains(location) {
                   changeSceneTo(sceneName.gameSingle, transitionName: transitionName.pushRight)
            }
            
            if homeButton.contains(location) {
                changeSceneTo(sceneName.menu, transitionName: transitionName.pushRight)
            }
            
            if shareButton.contains(location) {
                UserDefaults.standard.set( score, forKey: "currentScore")
               NotificationCenter.default.post(name: Notification.Name(rawValue: "shareScore"), object: nil)
            }
        
        }
    }

}


