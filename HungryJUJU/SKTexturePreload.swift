//
//  SKTexturePreload.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//
import SpriteKit

class MainScenePreloads {
    
    fileprivate static var _preload:  MainScenePreloads?
    
    static var preload:MainScenePreloads{
       
        if let preload = _preload {
             return preload
        }
        
        return  MainScenePreloads()
    }
    
    static func destroy() {
        _preload = nil
        print("MainScenePreloads: destroyed")
    }
    
    //MARK: Preloaded textures
    internal let kitchen = SKTexture(imageNamed: MainImg.name.kitchen)
    
    internal let table = SKTexture(imageNamed: MainImg.name.table)
    
    internal let foreground = SKTexture(imageNamed: MainImg.name.foreground)
    
    
    internal let juju = SKTexture(imageNamed: MainImg.name.juju)
    
    internal let  buttonPressed = SKTexture(imageNamed: MenuImg.name.buttonPressed)
}

class MenuScenePreloads {
    
    fileprivate static var _preload:   MenuScenePreloads?
    
    static var preload: MenuScenePreloads{
        
        if let preload = _preload {
            return preload
        }
        
        return  MenuScenePreloads()
    }
    
    static func destroy() {
        _preload = nil
        print("MenuScenePreloads: destroyed")
    }
    
    
    //MARK: Preloaded textures
    internal let logo = SKTexture(imageNamed: MenuImg.name.logo)
    
    internal let playButton = SKTexture(imageNamed: MenuImg.name.playButton)
    
    internal let multiplayerButton = SKTexture(imageNamed: MenuImg.name.multiplayerButton)
    
    internal let  gameCenterButton = SKTexture(imageNamed: MenuImg.name.gameCenterButton)
    
    internal let  infoButton = SKTexture(imageNamed: MenuImg.name.infoButton)
    
}

class GameScenePreloads {
    
    fileprivate static var _preload:  GameScenePreloads?
    
    static var preload:GameScenePreloads{
        
        if let preload = _preload {
            return preload
        }
        
        return GameScenePreloads()
    }
    
    static func destroy() {
        _preload = nil
        print("GameScenePreloads: destroyed")
    }
    
    //GameScene
    internal let  burger = textureArray(arrayName:"burger_")
    
    internal let  apple = textureArray(arrayName:"apple_")
    
    internal let  banana = textureArray(arrayName:"banana_")
    
    internal let  broccoli = textureArray(arrayName:"broccoli_")
    
    
    //GameOverScene
    internal let scoreCard = SKTexture(imageNamed: EndImg.name.scoreCard)
    
    internal let replayButton = SKTexture(imageNamed: EndImg.name.replayButton)
    
    internal let shareButton = SKTexture(imageNamed: EndImg.name.shareButton)
    
    internal let  homeButton = SKTexture(imageNamed: EndImg.name.homeButton)
    
    }


    

