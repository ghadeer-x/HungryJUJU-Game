//
//  moveComponent.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class MovementComponent:GKComponent {
    
    
    let spriteComponent: SpritComponent
    
    
    init( entity: GKEntity){
        // so we can get an easy refrence for the sprite
        self.spriteComponent = entity.component(ofType: SpritComponent.self)!
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func applyMovement(sceneSize:CGFloat, xAcc:CGFloat){
        
        let spritNode = spriteComponent.node
        
        spritNode.position.x += xAcc * 50
        
        if spritNode.position.x < -10 {
            spritNode.position = CGPoint(x: sceneSize + 10, y: spritNode.position.y)
        }else if spritNode.position.x > sceneSize + 10 {
            spritNode.position = CGPoint(x: -10, y: spritNode.position.y)
        }
    }
    
    
    
    
}
