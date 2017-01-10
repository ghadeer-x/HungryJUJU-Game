//
//  tutorialScene.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

class TutorialScene: MainScene {
    
     fileprivate let TutorialWorld = SKNode()
    //MARK: - Scene life cycle
   
    override func didMove(to view: SKView) {
       
        super.didMove(to: view)

        
        self.juju.position.y = table.size.height +  juju.size.height/2
        
        //Add nodes
        self.addChild(TutorialWorld)
        self.TutorialWorld.addChild(juju)
        self.TutorialWorld.addChild(foreground)
    }
    
    //MARK: - Input
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //If it's scene been show after pressed to start game at first change scene to game scene.
            changeSceneTo(sceneName.gameSingle, transitionName: transitionName.moveLeft)
        //Sound.sharedInstance().playSound(Sound.name.buttonPress)
    }
}
