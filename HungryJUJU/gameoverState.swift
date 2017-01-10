//
//  gameoverState.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameoverState:GKState{
    unowned let scene : GameScene
    let animationDelay = 0.3
    let popAction = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
    
    init(scene:SKScene){
        self.scene = scene as! GameScene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        //faild sound
        scene.stopFalling()
        showScoreCard()
        //scene.reportAllAchievementsForGameState()
        //scene.reportScoreToGameCenter(score: Int64(scene.score))
    }
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayingState.Type
    }
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    func setBestScore( _ bestScore:Int){
        UserDefaults.standard.set(bestScore, forKey: "BestScore")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "submitScore"), object: nil)
        UserDefaults.standard.synchronize()
    }
    
    func bestScore()->Int {
        return UserDefaults.standard.integer(forKey: "BestScore")
    }
    
    func showScoreCard(){
        if scene.score > bestScore() {
            setBestScore(scene.score)
        }
        
        scene.setupEndScene()
        
        // juice
        let moveTo =  SKAction.move(to: CGPoint(x: scene.size.width/2 , y: General.viewHeight * 0.6), duration: animationDelay)
        
        moveTo.timingMode = .easeInEaseOut
        
        scene.scoreCard.run(SKAction.sequence([
            SKAction.wait(forDuration: animationDelay * 2),
            moveTo]))
        
        scene.replayButton.alpha = 0
        scene.shareButton.alpha = 0
        scene.homeButton.alpha = 0
        
        scene.lastScore.text = "\(scene.score)"
        scene.bestScore.text = "\( bestScore() )"
        
        
        let fadeIn = SKAction.sequence([
            SKAction.wait(forDuration: animationDelay*3),
            SKAction.fadeIn(withDuration: animationDelay)])
        
        scene.replayButton.run(fadeIn)
        scene.shareButton.run(fadeIn)
        scene.homeButton.run(fadeIn)
       
        
       let pops = SKAction.sequence([
            SKAction.wait(forDuration: animationDelay),
            popAction,
            SKAction.wait(forDuration: animationDelay),
            popAction,
            SKAction.wait(forDuration: animationDelay),
            popAction,])
        
        scene.run(pops)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "rateUsAfterGame"), object: nil)
    }
}

