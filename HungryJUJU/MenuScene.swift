//
//  MenuScene.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene:  GlobalScene {
    
     override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Nodes
   
    
    fileprivate let buttonStart = ButtonNode(
        textureSimpleState: GraphicPreloadsGameScene.preload.buttonStart_simple,
        texturePressedState: GraphicPreloadsGameScene.preload.buttonStart_pressed,
        position: Img.position.buttonStart,
        zPosition: Img.zPosition.buttonStart)
    
        //MARK: - Scene life cycle
    override func didMove(to view: SKView) {
        //Settings node
      
        self.backgroundColor = General.backgroundColor
        
        self.table.anchorPoint = CGPoint.zero
        //Add nodes to scene
        self.addChild(kitchen)
        self.addChild(table)
        self.addChild(buttonStart)
    }
    
    //MARK: - Input
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if buttonStart.contains(location) {
                buttonStart.touchDown()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            //Change button state to simple
            buttonStart.touchUp()
           // buttonRateUs.touchUp()
            
            if buttonStart.contains(location) {
                //If play at first time show tutorial
                if UserDefaults.standard.bool(forKey: "ShowTutorial") {
                    UserDefaults.standard.set(false, forKey: "ShowTutorial")
                    UserDefaults.standard.set(true, forKey: "_pressToStart")
                    
                    //changeSceneTo(sceneName.tutorial, withTransitionName: transitionName.pushLeft)
                }
                else {
                   // changeSceneTo(sceneName.game, withTransitionName: transitionName.pushLeft)
                }
            }
            else {
                UserDefaults.standard.set(false, forKey: "_pressToStart")
            }
           /* if buttonRateUs.contains(location) {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "rateUs"), object: nil)
            }
            if buttonGameCenter.contains(location) {
                NotificationCenter.default.post(name: Notification.Name(rawValue: "showLeaderboard"), object: nil)
            }*/
           
        }
    }
}

