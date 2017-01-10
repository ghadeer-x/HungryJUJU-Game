//
//  playerEntity.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player:GKEntity{
    
    var spriteComponent: SpritComponent!
    var movementComponent: MovementComponent!
    
    // tempray flag ; will replace with player
    var movementAllowd = false
    
   
    
    var numberOfFrames = 3
    
    init( imageName:String) {
        super.init()
        let textuer = SKTexture(imageNamed: imageName)
        spriteComponent = SpritComponent(entity: self , textuer: textuer, size: textuer.size())
        
        addComponent(spriteComponent)
        movementComponent = MovementComponent( entity : self)
        addComponent(movementComponent)
        
        //add physics
        //using this tool http://insyncapp.net/SKPhysicsBodyPathGenerator.html
        
        let spritNode = spriteComponent.node
        
        spritNode.anchorPoint = CGPoint(x: 0.5 , y: 0.5)
        
        let  BodySize = CGSize(width:  spritNode.size.width/2.5, height:  spritNode.size.height/2.5 )
        
        spritNode.physicsBody = SKPhysicsBody(rectangleOf: BodySize)
        
        spritNode.physicsBody?.categoryBitMask = physicsCatagory.Juju
        spritNode.physicsBody?.collisionBitMask = 0
        spritNode.physicsBody?.contactTestBitMask = physicsCatagory.healthy | physicsCatagory.unhealthy
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
