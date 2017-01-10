//
//  MenuScene.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene:  MainScene {
   
     override init(size: CGSize , delegate: GameSceneDelegate!){
        super.init(size:size)
        if let gamedelegate = delegate {
        gameSceneDelegate = gamedelegate
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     fileprivate let MenuNodes = SKNode()
    
     fileprivate let logo = GNode(
        texture: MenuScenePreloads.preload.logo,
        position: MenuImg.position.logo,
        zPosition:Layer.ui.rawValue)
    
    //MARK: Nodes
    fileprivate let playButton = GButton(
        texture: MenuScenePreloads.preload.playButton,
        position: MenuImg.position.playButton,
        zPosition: Layer.ui.rawValue)
    
    fileprivate let multiplayerButton = GButton(
        texture: MenuScenePreloads.preload.multiplayerButton,
        position: MenuImg.position.multiplayerButton,
        zPosition: Layer.ui.rawValue)
    
    fileprivate let gameCenterButton = GButton(
        texture: MenuScenePreloads.preload.gameCenterButton,
        position: MenuImg.position.gameCenterButton,
        zPosition: Layer.ui.rawValue)
    
    fileprivate let infoButton = GButton(
        texture: MenuScenePreloads.preload.infoButton,
        position: MenuImg.position.infoButton,
        zPosition: Layer.ui.rawValue)
    
    
        //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        //self.backgroundColor = General.backgroundColor
        
        UserDefaults.standard.set(sceneName.menu.rawValue, forKey: "currentScene")
        
        self.juju.position.y = table.size.height +  juju.size.height/2
        
        //Add nodes
        self.addChild(MenuNodes)
        self.MenuNodes.addChild(juju)
        self.MenuNodes.addChild(logo)
        self.MenuNodes.addChild(playButton)
        self.MenuNodes.addChild(multiplayerButton )
        self.MenuNodes.addChild(gameCenterButton)
        self.MenuNodes.addChild(infoButton)
        self.MenuNodes.addChild(foreground)
    }
    
    //MARK: - Input
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if playButton.contains(location) {
                playButton.touchDown()
            }
            if multiplayerButton.contains(location) {
                multiplayerButton.touchDown()
            }
            if gameCenterButton.contains(location) {
               gameCenterButton.touchDown()
            }
            if infoButton.contains(location) {
                infoButton.touchDown()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            //Change button state
            playButton.touchUp()
            multiplayerButton.touchUp()
            gameCenterButton.touchUp()
            infoButton.touchUp()
            
            if playButton.contains(location) {
                //If play at first time show tutorial
                if UserDefaults.standard.bool(forKey: "ShowTutorial") {
                    UserDefaults.standard.set(false, forKey: "ShowTutorial")
                  
                    changeSceneTo(sceneName.tutorial, transitionName: transitionName.moveLeft)
                }
                else {
                   changeSceneTo(sceneName.gameSingle, transitionName: transitionName.pushRight)
                }
            }
            else {
                UserDefaults.standard.set(false, forKey: "_pressToStart")
            }
            if  multiplayerButton.contains(location) {
                 changeSceneTo(sceneName.gameMultiplayer, transitionName: transitionName.pushRight)
            }
            if gameCenterButton.contains(location) {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "showLeaderboard"), object: nil)
            }
            if infoButton.contains(location) {
                if let url = URL(string: "https://www.hackingwithswift.com") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
           
        }
    }
}

