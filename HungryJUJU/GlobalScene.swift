//
//  GlobalScene.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

class GlobalScene: SKScene {
    
    
    
    /**
     It's enum with all scenes in game. You can add some new scenes, and case to this enum. Also you need to decribe you scene like same in getScene() function.
     */
    enum sceneName: Int {
        case menu = 0
        case store = 1
        case settings = 2
        case tutorial = 3
        case game = 4
        case end = 5
    }
    
    /**
     It's enum with all possible animations for transition scene. You can add new case, after it you need describe this transition in getSceneTransition() function.
     */
    enum transitionName {
        case fade
        case pushUp
        case pushDown
        case pushLeft
        case pushRight
        case moveUp
        case moveDown
        case moveLeft
        case moveRight
        case without
    }
    
    let kitchen = SimpleNode(
        texture: GraphicPreloadsGameScene.preload.kitchen,
        position: Img.position.kitchen,
        zPosition: Img.zPosition.kitchen)
    
    let table = SimpleNode(
        texture: GraphicPreloadsGameScene.preload.table,
        position: Img.position.table,
        zPosition: Img.zPosition.table)
    
    
    //MARK: - Make screenshot
    
    /**
     This function make screenshot of you game scene. In default it's use for sharing function.
     
     - returns: This function save compleate screenshot in NSUserDefuaults by key "ScreenShot", you can get it by this key.
     */
    
    
    
    func makeScreenshot() {
        //Create the image
        UIGraphicsBeginImageContext(CGSize(width: frame.size.width, height: frame.size.height))
        self.view?.drawHierarchy(in: frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        //Save screen shot
        UserDefaults.standard.set(UIImagePNGRepresentation(image!), forKey: "ScreenShot");
    }
    
    //MARK: - Scenes controller
    
    /**
     Current function helped to you with changing scenes during game.
     
     - parameter nameScene: It's name of scene what you need to go, it's enum object decribed in GlobalScene.
     - parameter nameTransition: It's name of type changing your game scene. You can see all animations in GlobalScene.
     */
    func changeSceneTo(_ nameScene: sceneName, withTransitionName nameTransition: transitionName) {
        UserDefaults.standard.set(nameScene.rawValue, forKey: "_currentSceneLoaded")
        tryToCleanMemoryAndLoadTextureForScene(nameScene)
        
        //Create scene and transition
        let scene = getScene(nameScene)
        let transition = getSceneTransition(nameTransition)
        
        //Sound.sharedInstance().sceneForPlayingSounds = scene
                
        //Show new scene
        if transition != nil { self.view?.presentScene(scene, transition: transition!)}
        else { self.view?.presentScene(scene)}
        
        //Clean old scene after show new
        Timer.scheduledTimer(timeInterval: General.transitionSpeed, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    /**
     Current function get scene from SceneName enum.
     
     - parameter name: It's scene name from enum SceneName.
     - returns: SKScene object for change scene.
     */
    fileprivate func getScene(_ name: sceneName) -> SKScene {
        switch name {
        case .menu:
            return MenuScene(size: self.size)
        default:
            return MenuScene(size: self.size)
        }
    }
    
    /**
     Current function get transition from TransionName enum.
     
     - parameter name: It's transition name from enum TransitionName.
     - returns: SKTransition object with animation for change scene.
     */
    fileprivate func getSceneTransition(_ name: transitionName) -> SKTransition? {
        switch name {
        case .fade:
            return SKTransition.fade(withDuration: General.transitionSpeed)
        case .pushUp:
            return SKTransition.push(with: SKTransitionDirection.up, duration: General.transitionSpeed)
        case .pushDown:
            return SKTransition.push(with: SKTransitionDirection.down, duration: General.transitionSpeed)
        case .pushLeft:
            return SKTransition.push(with: SKTransitionDirection.left, duration: General.transitionSpeed)
        case .pushRight:
            return SKTransition.push(with: SKTransitionDirection.right, duration: General.transitionSpeed)
        case .moveUp:
            return SKTransition.moveIn(with: SKTransitionDirection.up, duration: General.transitionSpeed)
        case .moveDown:
            return SKTransition.moveIn(with: SKTransitionDirection.down, duration: General.transitionSpeed)
        case .moveLeft:
            return SKTransition.moveIn(with: SKTransitionDirection.left, duration: General.transitionSpeed)
        case .moveRight:
            return SKTransition.moveIn(with: SKTransitionDirection.right, duration: General.transitionSpeed)
        default:
            return nil
        }
    }
    
    /**
     If system call memory warning load cleaner for preload textures. And this function make this, also it's function load textures for next scene.
     
     - parameter name: It's current scene to load textures.
     */
    fileprivate func tryToCleanMemoryAndLoadTextureForScene(_ name: sceneName) {
        //This parameter it's can bee change in GameViewController in didReceiveMemoryWarning() function.
        if UserDefaults.standard.bool(forKey: "_needToCleanMemory") {
            if name != .menu { GraphicPreloadsGameScene.destroy()}
            if UserDefaults.standard.bool(forKey: "_needToCleanMemoryFatal") {
                if name != .game { GraphicPreloadsGameScene.destroy()}
            }
            
            switch name {
            case .menu:
                _ = GraphicPreloadsGameScene.preload
            case .game:
                _ = GraphicPreloadsGameScene.preload
            default:
                 _ = GraphicPreloadsGameScene.preload
            }
        }
    }
    
    /**
     This function helped to clean old scene from something nodes and actions
     */
    func cleanOldScene() {
        self.removeAllChildren()
        self.removeAllActions()
        self.removeFromParent()
        
        print("GlobalScene: Old scene is been cleaned")
    }
}
