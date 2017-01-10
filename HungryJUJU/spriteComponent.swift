//
//  spriteComponent.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit

class EntityNode:SKSpriteNode {
    weak var entiy:GKEntity!
}

class SpritComponent:GKComponent {
    let node:EntityNode
    
    init( entity:GKEntity , textuer:SKTexture , size:CGSize ){
        node = EntityNode( texture: textuer, color: SKColor.white , size: size)
        node.entiy = entity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

