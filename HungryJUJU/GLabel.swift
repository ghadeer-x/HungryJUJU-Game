//
//  GLabel.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//


import SpriteKit

class SimpleLabel: SKLabelNode {
    
    //MARK: - Initialisations
    
    /**
     Initialise label
     
     - property text: String with text for label.
     - property fontSize: CGFloat value with label font size.
     - property fontColorHex: String with code of color for label. It's be look like "#ffffff".
     - property position: CGPoint object with position new label on scene.
     - property zPosition: CGFloat value for set position label by z coordinate on scene.
     */
    init(text: String, fontSize: CGFloat, Color:UIColor, position: CGPoint, zPosition: CGFloat) {
        super.init()
        self.text = text
        self.fontName = General.fontName
        
        //If game launch on iPad scale font size by x2
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad { self.fontSize = fontSize * 1.2}
        else { self.fontSize = fontSize}
        
        self.position = position;
        self.zPosition = zPosition;
        self.color = Color
        self.verticalAlignmentMode = .center
        self.horizontalAlignmentMode = .center
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleLabel init(coder:) has not been implemented")}
    
    //MARK: - Animations
    
   /* func changeTextWithAnimationScaled(withText text: String) {
        self.text = text
        self.removeAllActions()
        self.run(SKAction.sequence([
            SKAction.scale(to: 1.2, duration: SettingsGameProcess.speedAnimationChangeLabel / 2),
            SKAction.scale(to: 1, duration: SettingsGameProcess.speedAnimationChangeLabel / 2)]))
    }*/
    
    //MARK: - You features
    
}

