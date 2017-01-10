//
//  GameScenePhysicsWorld.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func GameScenePhysicsWorld() {
        
        physicsWorld.gravity = CGVector(dx: 0 , dy: 0 )
        physicsWorld.contactDelegate = self
        
        let lowerLeft = CGPoint(x: 0, y: table.size.height)
        let lowerRight = CGPoint(x: table.size.height , y: table.size.height)
        
        physicsBody = SKPhysicsBody(edgeFrom: lowerLeft, to: lowerRight)
        
        physicsBody?.categoryBitMask = physicsCatagory.ground
        physicsBody?.collisionBitMask  = 0
        physicsBody?.contactTestBitMask = physicsCatagory.healthy | physicsCatagory.unhealthy
    
    }
    
    func didBegin( _ contact: SKPhysicsContact){
        let collision = contact.bodyA.categoryBitMask
            | contact.bodyB.categoryBitMask
        
        let ground = contact.bodyA.categoryBitMask == physicsCatagory.ground ? contact.bodyB : contact.bodyA
        
        if (ground.categoryBitMask == physicsCatagory.unhealthy )||(ground.categoryBitMask == physicsCatagory.healthy)  {
            ground.node?.removeFromParent()
        }
        
        if collision == physicsCatagory.Juju | physicsCatagory.healthy {
            let node = contact.bodyB.node
            node?.removeFromParent()
            print("\(node?.name)")
            noOfCollisions += 1
            updateScore()
        }
        
        if collision == physicsCatagory.Juju | physicsCatagory.unhealthy {
            contact.bodyB.node?.removeFromParent()
            for index in 0..<playerArr.count{
                playerArr[index].spriteComponent.node.texture = SKTexture(imageNamed: "juju_2")
            }
            gameState.enter(GameoverState.self)
        }
    }
    
    func updateScore(){
        self.score += 1
        self.scoreLabel.text = "\(score)"
        //self.run(self.coinAction)
    }


}
