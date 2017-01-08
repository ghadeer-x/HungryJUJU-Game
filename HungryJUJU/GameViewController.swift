//
//  GameViewController.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //Get info for creating scene
        UserDefaults.standard.set(Float(self.view.frame.size.width), forKey: "SizeWidth")
        UserDefaults.standard.set(Float(self.view.frame.size.height), forKey: "SizeHeight")
        
        
        let scene = MenuScene(size:CGSize(width: 1536 , height: 2048 ))
        
        
        
            //Check firsh launch
            if !(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
                
                //First launch
                UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
                
                //Set stats
                UserDefaults.standard.set(true, forKey: "ShowTutorial")
                
                UserDefaults.standard.set(true, forKey: "PlaySounds")
                UserDefaults.standard.set(true, forKey: "PlayMusic")
                
                UserDefaults.standard.set(1, forKey: "CurrentSkin")
                
                UserDefaults.standard.set(0, forKey: "CurrentScore")
                UserDefaults.standard.set(0, forKey: "BestScore")
                
                UserDefaults.standard.set(false, forKey: "neverRateAfterGame")
        }
            //Configure view
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.ignoresSiblingOrder = true
                skView.showsPhysics = true
                scene.scaleMode = .aspectFill
              
            
            //Make setup for first launch
            UserDefaults.standard.set(false, forKey: "_needToCleanMemoryFatal")
            
            UserDefaults.standard.set(false, forKey: "_needToCleanMemory")
            
            //Load some components
            _ = GraphicPreloadsGameScene.preload

            
           // Sound.sharedInstance().playMusic()
           // Sound.sharedInstance().sceneForPlayingSounds = scene
            
            //AdController.showAdInScene(GlobalScene.sceneName.menu)
            
            //Load other feature
            authenticateLocalPlayer()
            
            //Get links
            NotificationCenter.default.addObserver(self, selector: #selector(showLeaderboard), name: NSNotification.Name(rawValue: "showLeaderboard"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(submitScore), name: NSNotification.Name(rawValue: "submitScore"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(getLeaderboard), name: NSNotification.Name(rawValue: "getLeaderboard"), object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(share), name: NSNotification.Name(rawValue: "share"), object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(rateUs), name: NSNotification.Name(rawValue: "rateUs"), object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(rateUsAfterGame), name: NSNotification.Name(rawValue: "rateUsAfterGame"), object: nil)
            
            
            //Show loaded scene
            skView.presentScene(scene)
    }
    
    override func didReceiveMemoryWarning() {
        if UserDefaults.standard.bool(forKey: "_needToCleanMemory") {
            UserDefaults.standard.set(true, forKey: "_needToCleanMemoryFatal")
        }
        UserDefaults.standard.set(true, forKey: "_needToCleanMemory")
        cleanPreloads()
        print("System is been loaded, out of memory. Make avaliable cleaning of preloads graphic files")
    }
    
    fileprivate func cleanPreloads() {
        /*
        let currentSceneLoadedNumber = UserDefaults.standard.integer(forKey: "_currentSceneLoaded")
        
        let currentSceneLoaded: GlobalScene.sceneName = GlobalScene.sceneName(rawValue: currentSceneLoadedNumber)!
    
        if currentSceneLoaded != GlobalScene.sceneName.menu { GraphicPreloadsMenuScene.destroy()}
        
        if UserDefaults.standard.bool(forKey: "_needToCleanMemoryFatal") {
            if currentSceneLoaded != GlobalScene.sceneName.game { GraphicPreloadsGameScene.destroy()}
        }
 */
    }
    
    //MARK: - Ad's
    
    
    
    //MARK: - GameCenter
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            if (viewController != nil) { self.present(viewController!, animated: true, completion: nil)}
            else {
                print("GameCenter: Authenticate compleate")
            }
        }
    }
    
    func submitScore() {
        let score = GKScore(leaderboardIdentifier: General.GameCenter.leaderboard)
        score.value = Int64(UserDefaults.standard.integer(forKey: "BestScore"))
        
        GKScore.report([score], withCompletionHandler: { (error: Error?) -> Void in
            if error != nil { print(error!.localizedDescription)}
            else { print("GameCenter: Score submited")}
        })
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func showLeaderboard() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
        gcVC.leaderboardIdentifier = General.GameCenter.leaderboard
        self.present(gcVC, animated: true, completion: nil)
    }
    
    func getLeaderboard() {
        /*
        let board = GKLocalPlayer.localPlayer()
         board.loadFriendPlayers(completionHandler: { (players, error) -> Void in
            print(players)
        })*/
    }
    
    
    //MARK: - Some social features
    
    func share() {
        let text: String  = General.SomeSocialStats.shareText
        let dataImage: Data = UserDefaults.standard.object(forKey: "ScreenShot") as! Data
        let image: UIImage = UIImage(data: dataImage)!
        let shareItems: Array = [image, text] as [Any]
        
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view;
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.copyToPasteboard, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func rateUsAfterGame() {
        if !UserDefaults.standard.bool(forKey: "neverRateAfterGame") {
            let alert = UIAlertController(title: "Rate Us", message: "Thanks for playing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Rate", style: UIAlertActionStyle.default, handler: { alertAction in
                UIApplication.shared.openURL(URL(string : General.SomeSocialStats.linkToRateUs)!)
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "No Thanks", style: UIAlertActionStyle.default, handler: { alertAction in
                UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func rateUs() {
        let alert = UIAlertController(title: "Rate Us", message: "If you like this game rate it in AppStore", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { alertAction in
            UIApplication.shared.openURL(URL(string : General.SomeSocialStats.linkToRateUs)!)
            UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Some system settings
    
    override var prefersStatusBarHidden: Bool {
        return true
}

}
