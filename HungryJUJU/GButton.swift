//
//  GButton.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

class GButton: GNode {
    
    //Value store button state
    var IsPressed = false
    
    //Object with textures for any states of button
    fileprivate var mainTexture: SKTexture?
    fileprivate let pressedTexture:SKTexture = MainScenePreloads.preload.buttonPressed
    
    //MARK: - Initialistions
    init(name: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        
        super.init(imageName: name, position: position, zPosition: zPosition)
        
        mainTexture = self.texture
        
    }
    
    override init(texture: SKTexture, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: texture, position: position, zPosition: zPosition)
        
        mainTexture = texture
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    
    fileprivate func updateButtonTexture() {
        if IsPressed { self.texture = pressedTexture}
        else { self.texture = mainTexture}
    }
    
    func touchDown() {
        IsPressed = true
        updateButtonTexture()
    }
    
    func touchUp() {
        if IsPressed {
            IsPressed = false
            // Sound.sharedInstance().playSound(Sound.name.buttonPress)
            updateButtonTexture()
        }
    }
    
}
