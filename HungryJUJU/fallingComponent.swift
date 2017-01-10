//
//  fallingComponent.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/9/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit

class FallingComponent:GKComponent {
    
    
    let spriteComponent: SpritComponent
    
    init( entity: GKEntity){
        // so we can get an easy refrence for the sprite
        self.spriteComponent = entity.component(ofType: SpritComponent.self)!
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func applyFalling(){
        
        let spritNode = spriteComponent.node
        
        let moveY = General.viewHeight + spritNode.size.width
        let moveDuration = moveY/150
        
        let sequence = SKAction.sequence([
            SKAction.moveBy(x: 0 , y: -moveY , duration: TimeInterval(moveDuration)),
            SKAction.removeFromParent()])
        
        spritNode.run(sequence)
        
    }
    
    
}
