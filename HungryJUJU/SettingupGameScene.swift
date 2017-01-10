//
//  SettingupGameScene.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/10/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

extension GameScene{
    
    func setupEndScene(){
        
        // fix the positioning
        lastScore.position = CGPoint(x: -scoreCard.size.width * 0.25 , y: -scoreCard.size.height * 0.2)
        bestScore.position = CGPoint(x: scoreCard.size.width * 0.25 , y: -scoreCard.size.height * 0.2)
        
        lastScoreText.position = CGPoint(x: lastScore.position.x , y: -scoreCard.size.height * 0.32)
        bestScoreText.position = CGPoint(x:  bestScore.position.x , y: -scoreCard.size.height * 0.32)
        
        // adding
        gameSceneWorld.addChild(scoreCard)
        scoreCard.addChild(lastScore)
        scoreCard.addChild(bestScore)
        scoreCard.addChild(lastScoreText)
        scoreCard.addChild(bestScoreText)
        gameSceneWorld.addChild(replayButton)
        gameSceneWorld.addChild(homeButton)
        gameSceneWorld.addChild(shareButton)
        
    }
    
    func setupForground(){
        
        let foreground2 = GNode(
            texture: MainScenePreloads.preload.foreground,
            position: CGPoint(x:0 , y: foreground.size.height ),
            zPosition: MainImg.zPosition.foreground )
        
        foreground2.anchorPoint = CGPoint.zero
        
        self.gameSceneWorld.addChild(foreground)
        self.gameSceneWorld.addChild(foreground2)
        
        scrollingForeground = ParallaxSprite(
            sprite1: foreground,
            sprite2: foreground2,
            speed: -15
        )
    }
    
    // Single player
    func setupPlayer(pl: Player , i: CGFloat ) {
        let playrNode = pl.spriteComponent.node
        playrNode.zPosition = Layer.juju.rawValue
        playrNode.position = CGPoint(x: size.width/2 + ( i * playrNode.size.width ), y: juju.position.y)
        gameSceneWorld.addChild(playrNode)
    }
    
    func setupFood(){
        
        
        // creat Entity
        let food = Food()
        food.animationComponent.startAnimation()
       
        // grap the spriteNode with that entity
        let foodNode = food.spriteComponent.node
        foodNode.zPosition = Layer.food.rawValue
        foodNodes.addChild(foodNode)
        food.fallingComponent.applyFalling()
    }
    
    

    

}
