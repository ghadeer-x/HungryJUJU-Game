//
//  SKTexturePreload.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//
import SpriteKit
class GraphicPreloadsGameScene {
    
    fileprivate static var _preload: GraphicPreloadsGameScene?
    
    static var preload: GraphicPreloadsGameScene {
        if _preload == nil {
            _preload = GraphicPreloadsGameScene()
            print("GraphicPreloads class: Compleate loading graphic files for game scene")
        }
        return _preload!
    }
    
    static func destroy() {
        _preload = nil
        print("GraphicPreloads class: Graphicfiles for game scene is been destroyed")
    }
    
    //MARK: Preloaded textures
    internal let kitchen = SKTexture(imageNamed: Img.name.kitchen)
    
    internal let table = SKTexture(imageNamed: Img.name.table)
    
    internal let buttonStart_simple = SKTexture(imageNamed: Img.name.buttonStart_simple)
    
    internal let buttonStart_pressed = SKTexture(imageNamed: Img.name.buttonStart_pressed)
    
}
