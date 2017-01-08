//
//  ButtonNode.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

class ButtonNode: SimpleNode {
    
    //Value store button state
    var currentButtonStateIsPressed = false
    
    //Object with textures for any states of button
    fileprivate var textureSimple: SKTexture?
    fileprivate var texturePressed: SKTexture?
    
    //MARK: - Initialistions
    init(imageSimpleName: String, imagePressedName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        
        super.init(imageName: imageSimpleName, position: position, zPosition: zPosition)
        
        textureSimple = self.texture
        texturePressed = SKTexture(imageNamed: imagePressedName)
        
    }
    
    init(textureSimpleState: SKTexture, texturePressedState: SKTexture, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: textureSimpleState, position: position, zPosition: zPosition)
        
        textureSimple = textureSimpleState
        texturePressed = texturePressedState
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("ButtonNode init(coder:) has not been implemented")}
    
    fileprivate func updateButtonTexture() {
        if currentButtonStateIsPressed { self.texture = texturePressed}
        else { self.texture = textureSimple}
    }
    
    func touchDown() {
        currentButtonStateIsPressed = true
        updateButtonTexture()
    }
    

    func touchUp() {
        if currentButtonStateIsPressed {
            currentButtonStateIsPressed = false
            
           // Sound.sharedInstance().playSound(Sound.name.buttonPress)
            updateButtonTexture()
        }
    }
    
    //MARK: - You features
}
