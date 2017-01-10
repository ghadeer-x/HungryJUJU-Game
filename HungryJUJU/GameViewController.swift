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

class GameViewController: UIViewController, GKGameCenterControllerDelegate, GameSceneDelegate {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MenuScene(size:CGSize(width: 1536 , height: 2048 ) ,delegate:self )
        
        //Configure view
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true
        scene.scaleMode = .aspectFill
              
            
        //Make setup for first launch
        
        let maxAspectRatio:CGFloat = 16.0/9.0
        let height = General.viewHeight
        let playableWidth = height / maxAspectRatio
        
        //If game launch on iPad change playableWidth
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            
            UserDefaults.standard.set(Int(playableWidth + 200), forKey: "playableWidth")
            
        }else {
            UserDefaults.standard.set(Int(playableWidth), forKey: "playableWidth")
        }
        
        UserDefaults.standard.set(false, forKey: "MemoryFatal")
        UserDefaults.standard.set(false, forKey: "MemoryWarning")
         UserDefaults.standard.set(false, forKey: "neverRateAfterGame")
        UserDefaults.standard.set(0, forKey: "currentScene")
        UserDefaults.standard.set(0, forKey: "currentScore")
        
        //Load some components
        _ = MainScenePreloads.preload
        _ = MenuScenePreloads.preload
        _ = GameScenePreloads.preload
 
            
        // Sound.sharedInstance().playMusic()
        // Sound.sharedInstance().sceneForPlayingSounds = scene
            
        //AdController.showAdInScene(GlobalScene.sceneName.menu)
            
        // authenticateLocalPlayer
        authenticateLocalPlayer()
        
          NotificationCenter.default.addObserver(self, selector: #selector(shareScore), name: NSNotification.Name(rawValue: "shareScore"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showGameCenter), name: NSNotification.Name(rawValue: "showGameCenter"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(submitScore), name: NSNotification.Name(rawValue: "submitScore"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(rateUsAfterGame), name: NSNotification.Name(rawValue: "rateUsAfterGame"), object: nil)

        //Show loaded scene
        skView.presentScene(scene)
    }
    
    
    
    
    
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
    
    func screenShot()-> UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false , 1.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    func shareString(String:String , url:URL , image:UIImage){
        
        // Initialize and present UIActivityViewController
        let activity = UIActivityViewController(activityItems: [String, url, image], applicationActivities: nil)
        
        present(activity, animated: true, completion: nil)
        
    }
    func shareScore(){
        let score = UserDefaults.standard.integer(forKey: "currentScore")
            let urlString = "https://itunes.apple.com/app/flappy/id\(General.appStorID)?mt=8"
            let url = URL(string: urlString)
            let screenShot =  self.screenShot()
            let initialStringText =  " جبت \(score) نقاط في لعبة جوجو جوعانه! "
            shareString( String: initialStringText , url: url! , image: screenShot)
        }
    
    func submitScore() {
        let score = GKScore(leaderboardIdentifier: GameCenter.Leaderboard.ID)
        score.value = Int64(UserDefaults.standard.integer(forKey: "BestScore"))
        
        GKScore.report([score], withCompletionHandler: { (error: Error?) -> Void in
            if error != nil { print(error!.localizedDescription)}
            else { print("GameCenter: Score submited")}
        })
    }
    
    func showGameCenter() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        self.present(gcVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
     func rateUsAfterGame() {
        if !UserDefaults.standard.bool(forKey: "neverRateAfterGame") {
            let alert = UIAlertController(title: "قيمنا", message: "شاركنا رأيك", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "قيمنا", style: UIAlertActionStyle.default, handler: { alertAction in
                
                if let url = URL(string: "https://www.hackingwithswift.com") {
                    UIApplication.shared.open(url, options: [:])
                }
    
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: " لا شكرا", style: UIAlertActionStyle.default, handler: { alertAction in
                UserDefaults.standard.set(true, forKey: "neverRateAfterGame")
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "لاحقاً", style: UIAlertActionStyle.default, handler: { alertAction in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        let currentSceneNumber = UserDefaults.standard.integer(forKey: "currentScene")
        
        // for the first time
        if UserDefaults.standard.bool(forKey: "MemoryWarning") {
            UserDefaults.standard.set(true, forKey: "MemoryFatal")
        }
        
        UserDefaults.standard.set(true, forKey: "MemoryWarning")
        
        if UserDefaults.standard.bool(forKey: "MemoryWarning") {
            if currentSceneNumber !=
                MainScene.sceneName.menu.rawValue { MenuScenePreloads.destroy()}
            
            
            //don't remove game textures uless the system have memory problem.
            if UserDefaults.standard.bool(forKey: "MemoryFatal") {
                if (currentSceneNumber != MainScene.sceneName.gameSingle.rawValue ) && (currentSceneNumber != MainScene.sceneName.gameMultiplayer.rawValue )   { GameScenePreloads.destroy()}
                
                print("Receiving Memory Warning ")
            }
        }
    }
    
    //MARK: - Some system settings
    override var prefersStatusBarHidden: Bool {
        return true
}
}

