//
//  ParallaxSprite.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit


class ParallaxSprite{
    
    let _sprite1:SKSpriteNode!
    let _sprite2:SKSpriteNode!
    let _s2PositionY: CGFloat!
    let _s1PositionY: CGFloat!
    let _speed : CGFloat!
    
    init(sprite1:SKSpriteNode , sprite2:SKSpriteNode, speed: CGFloat){
    
        
        _sprite1 = sprite1
        _sprite2 = sprite2
        _speed = speed
        
        _s1PositionY = _sprite1.position.y
        _s2PositionY = _sprite2.position.y
        
    }
    
    func update(){
        
        _sprite1.position.y += _speed
        _sprite2.position.y += _speed
        
        
        if _sprite1.position.y < -_sprite1.size.width{
            _sprite1.position += CGPoint(x:0 ,y:_sprite1.size.height * 2)
        }
        
        
        if _sprite2.position.y < -_sprite2.size.width{
            _sprite2.position += CGPoint(x:0 ,y:_sprite2.size.height * 2)
        }

    }
}
