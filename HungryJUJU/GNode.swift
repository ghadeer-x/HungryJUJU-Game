//
//  GNode.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

class GNode: SKSpriteNode {
    
    //MARK: - Initialisation
    init(imageName: String, position: CGPoint, zPosition: CGFloat) {
        let skTextuer = SKTexture(imageNamed: imageName)
        super.init(texture: skTextuer , color: UIColor.clear, size: skTextuer.size())
        self.position = position
        self.zPosition = zPosition
    }
    
    init(texture: SKTexture, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        self.position = position
        self.zPosition = zPosition
        
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    
}

