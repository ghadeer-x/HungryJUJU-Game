//
//  playingState.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit


class PlayingState:GKState{
    unowned let scene : GameScene
    
    init(scene:SKScene){
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        startFalling()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameoverState.Type
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        scene.scrollingForeground.update()
    }
    
    func startFalling(){
        
        let falling = SKAction.run(scene.setupFood)
        
        let everyDelay = SKAction.wait(forDuration:  General.everyDelay)
        
        let fallingSequence = SKAction.sequence([falling,everyDelay])
        
        let fallinForever = SKAction.repeatForever(fallingSequence)
        
        scene.run(fallinForever, withKey: "fall")
    }
    

}

