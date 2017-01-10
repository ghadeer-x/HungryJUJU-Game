//
//  singleState.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/9/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit


class SingleState:GKState{
    unowned let scene : GameScene
    
    init(scene:SKScene){
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        
        //Add ScoreLabel 
        scene.gameSceneWorld.addChild(scene.scoreLabel)
    
        //1 Select a color
        let player = Player(imageName: "juju_1")
        
        //2 Set the position
        scene.setupPlayer( pl: player , i: 0 )
        
        //3 Add to Players array
        scene.playerArr.append(player)
        scene.gameState.enter(PlayingState.self)
        
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayingState.Type
    }
    override func update(deltaTime seconds: TimeInterval) {
        scene.scrollingForeground.update()
        
    }
}
