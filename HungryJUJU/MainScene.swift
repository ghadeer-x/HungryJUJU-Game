//
//  MainScene.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

class MainScene: SKScene {
    
   var gameSceneDelegate:GameSceneDelegate!
    
    enum sceneName:Int {
        case menu = 0
        case tutorial = 4
        case gameSingle = 1
        case gameMultiplayer = 2
    }
    
    enum transitionName {
        case fade
        case pushUp
        case pushRight
        case moveLeft
    }
    
    //var delegate:   ?
    
    let kitchen = GNode(
        texture: MainScenePreloads.preload.kitchen,
        position: MainImg.position.kitchen,
        zPosition: MainImg.zPosition.kitchen)
    
    let table = GNode(
        texture: MainScenePreloads.preload.table,
        position: MainImg.position.table,
        zPosition: MainImg.zPosition.table)
    
    let foreground = GNode(
        texture: MainScenePreloads.preload.foreground,
        position: MainImg.position.foreground,
        zPosition: MainImg.zPosition.foreground)
    
    let juju = GNode(
        texture: MainScenePreloads.preload.juju,
        position: MainImg.position.juju,
        zPosition: MainImg.zPosition.juju)
   
    init(size: CGSize,delegate: GameSceneDelegate!) {
        if let gamedelegate = delegate {
            gameSceneDelegate = gamedelegate
        }
        super.init(size:size)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        self.backgroundColor = General.backgroundColor
        //positioning some node
        self.table.anchorPoint = CGPoint.zero
        self.foreground.anchorPoint = CGPoint.zero
        self.juju.position.y = table.size.height +  juju.size.height/2
        self.addChild(kitchen)
        self.addChild(table)
    
    }
   
    //Scenes controller
    func changeSceneTo( _ sceneName: sceneName,  transitionName: transitionName) {
        
        //Create scene and transition
        let scene = getScene(sceneName)
        let transition = getSceneTransition(transitionName)
        
        //Sound.sharedInstance().sceneForPlayingSounds = scene
        
        //Show new scene
        UserDefaults.standard.set( sceneName.rawValue , forKey: "currentScene")

        self.view?.presentScene(scene, transition: transition!)
        //Clean old scene after show new
        Timer.scheduledTimer(timeInterval: General.transitionSpeed, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    fileprivate func getScene(_ name: sceneName) -> SKScene {
        switch name {
        case .menu:
            return MenuScene(size: self.size, delegate:gameSceneDelegate)
        case .tutorial:
            return TutorialScene(size: self.size)
        case .gameSingle:
            return GameScene(size: self.size, stateClass: SingleState.self, mode: GameScene.mode.single , delegate:gameSceneDelegate)
        case .gameMultiplayer:
            return GameScene(size: self.size, stateClass: SingleState.self, mode: GameScene.mode.multiplayer , delegate:gameSceneDelegate)
        }
    }
    

    fileprivate func getSceneTransition(_ name: transitionName) -> SKTransition? {
        switch name {
        case .fade:
            return SKTransition.fade(withDuration: General.transitionSpeed)
        case .pushUp:
            return SKTransition.push(with: SKTransitionDirection.up, duration: General.transitionSpeed)
        case .pushRight:
            return SKTransition.push(with: SKTransitionDirection.right, duration: General.transitionSpeed)
        case .moveLeft:
            return SKTransition.moveIn(with: SKTransitionDirection.left, duration: General.transitionSpeed)
        }
    }
    
    func cleanOldScene() {
        self.removeAllChildren()
        self.removeAllActions()
        self.removeFromParent()
        print("cleaned")
    }
}

