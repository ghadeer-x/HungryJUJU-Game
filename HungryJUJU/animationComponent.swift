//
//  animationComponent.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit


class AnimationComponent:GKComponent {
    
    let spriteComponent: SpritComponent
    var textures:[SKTexture] = []
    
    init( entity:GKEntity, textures:[SKTexture]){
        self.textures = textures
        self.spriteComponent = entity.component(ofType: SpritComponent.self)!
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    func startAnimation(){
        let playerAnimation = SKAction.animate(with: textures, timePerFrame: 0.2)
        spriteComponent.node.run(SKAction.repeatForever(playerAnimation))
        
    }
    
    func stopAnimation(){
        spriteComponent.node.removeAllActions()
        
    }
}

