//
//  foodEntity.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//


import GameplayKit
    


 class Food:GKEntity {
        
        // we need a variable to hold the component of sprite component
        var spriteComponent: SpritComponent!
        var animationComponent:AnimationComponent!
        var fallingComponent: FallingComponent!
        var imageName:String!
    
        var healthyArray = ["apple_", "banana_", "broccoli_"]
        var unhealthyArray = ["burger_"]
    
    
    enum type {
        case healthy
        case unhealthy
    }
    
    var currentType: type = .unhealthy
        
        // the init statment will accept the parameter of the image name
        // it will set a texture . set a sprite comonent variable and the add the component to the entity
        override init() {
            
            super.init()
            
            if Double(from: 0.0, to: 50.0) < General.changeToHealthy {
                currentType = .healthy
                imageName = possibleFood(foodArray:healthyArray)
            }else {
                 imageName = possibleFood(foodArray:unhealthyArray)
                
            }
            
            let textuer = foodTextuer(name:imageName)
            
            spriteComponent = SpritComponent(entity: self , textuer: textuer[0], size: textuer[0].size())
            addComponent(spriteComponent)
            
            fallingComponent = FallingComponent( entity : self)
            addComponent(fallingComponent)
          
            animationComponent = AnimationComponent(entity: self , textures: textuer)
            addComponent(animationComponent)
            
            //add physics
            let spritNode = spriteComponent.node
            randPosition(node: spritNode)
            
            let BodySize = CGSize(width:  spritNode.size.width/2, height:  spritNode.size.height/2 )
            
            spritNode.physicsBody = SKPhysicsBody(rectangleOf: BodySize)
            
            spritNode.physicsBody?.collisionBitMask = 0
            spritNode.physicsBody?.contactTestBitMask = physicsCatagory.Juju
            
            if currentType == .healthy {
                spritNode.physicsBody?.categoryBitMask = physicsCatagory.healthy
                spritNode.name =  imageName
            } else {
                spritNode.physicsBody?.categoryBitMask = physicsCatagory.unhealthy
            }
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func foodTextuer(name:String) -> [SKTexture] {
        
        switch name {
        case "burger_":
            return GameScenePreloads.preload.burger
        case "apple_":
            return GameScenePreloads.preload.apple
        case "banana_":
            return GameScenePreloads.preload.banana
        case "broccoli_":
            return GameScenePreloads.preload.broccoli
        default:
            return GameScenePreloads.preload.burger
        }

    }
    
    func possibleFood( foodArray:[String])-> String {
        let possipalFood = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: foodArray) as! [String]
        return possipalFood[0]
    }
    
    func randPosition( node : SKSpriteNode){
        
        let playableMargin = (Int(General.viewWidth)-General.playableWidth)/2
        
        let position = Double(from: Double(playableMargin), to: Double(General.playableWidth) + 200)
        
        node.position = CGPoint(x: CGFloat(position), y: General.viewHeight + node.size.height)
        
    }
    

        
    }

