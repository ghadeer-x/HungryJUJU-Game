//
//  Settings.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

// creat an enum for zposition
enum Layer:CGFloat {
    case foreground
    case kitchen
    case juju
    case food
    case ui
    case label
    case table
}

protocol GameSceneDelegate{
    func screenShot() -> UIImage
    func shareString( String:String , url:URL , image:UIImage)
}


struct General {
    
    static let viewWidth:CGFloat  = 1536
    static let viewHeight:CGFloat  = 2048
    
    static let playableWidth = UserDefaults.standard.integer(forKey: "playableWidth")
    
    static let margin:CGFloat = 30
    static let fontName: String = ".SFUIDisplay-Light"
    
    static let backgroundColor = UIColor(red: 52.0/255.0, green: 134/255.0, blue: 126/255.0, alpha: 1.0)
    
    static let transitionSpeed: Double = 0.8
    static let everyDelay:TimeInterval = 0.2

    static let foregroundSpeed:CGFloat = 250
    static let changeToHealthy: Double = 30.0
    static let appStorID = 5465656
    
    struct SomeSocialStats {
        static let shareText = "Try to beat my score!"
        static let linkToRateUs = "http://google.com/"
    }
    

    
    
}



struct GameCenter {
    
    static var gameCenterEnabled = false
    //static let leaderboardIDMap = ["HighestScore": "com.guidogame.HungryJUJU.HighestScore"]
    // to track if the game is multiplyer mode
    //static var multiplayerMatchStarted: Bool
    
    
    struct Leaderboard{
        static let ID = "com.guidogame.HungryJUJU.HighestScore"
    }
    struct Achievement {
        static let MaxEggCollisions = 20.0
        static let MaxSandwichCollisions = 10.0
        static let BodyPowerAchievementId =
        "com.guidogame.HungryJUJU.bodypower"
    }
}

struct physicsCatagory{
    static let None:UInt32 = 0 //0
    static let Juju:UInt32 = 0b1 //0
    static let healthy:UInt32 = 0b10 //0
    static let unhealthy:UInt32 = 0b100 //0
    static let ground:UInt32 = 0b1000
}


struct GLabels {
    
    
    static let  color:UIColor = SKColor.white
    static let size:CGFloat = 65
    
    
    struct position {
        static let scoreLabel:CGPoint = CGPoint(x:General.viewWidth/2 , y: General.viewHeight - General.margin)
        
        static let bestScore = CGPoint(
            x: General.viewWidth * 0.25 ,
            y: 0)
        
    }

   
    
    
    
}


// Image Settings
struct MainImg {
    
    struct name {
        static let foreground:String = "foreground"
        static let kitchen:String = "kitchen"
        static let table:String = "table"
        static let juju:String = "juju_1"
    }
    
    struct position {
        static let kitchen:CGPoint = CGPoint(x:General.viewWidth/2, y: General.viewHeight * 0.80 )
        static let table:CGPoint = CGPoint.zero
        static let foreground:CGPoint = CGPoint.zero
        static let juju:CGPoint = CGPoint(x: General.viewWidth/2, y:  0)
        
    }
    
    struct zPosition {
        static let foreground:CGFloat = Layer.foreground.rawValue
        static let kitchen: CGFloat = Layer.kitchen.rawValue
        static let table: CGFloat = Layer.table.rawValue
        static let juju: CGFloat = Layer.juju.rawValue
    }
    
    
}

struct MenuImg {
    
    struct name {
        static let logo = "logo"
        static let playButton = "play"
        static let multiplayerButton = "multiplayerMode"
        static let gameCenterButton = "gameCenter"
        static let infoButton = "info"
        static let buttonPressed = "pressed"
    }
    
    struct position {
        
       static let logo = CGPoint(x: General.viewWidth/2, y: General.viewHeight * 0.68)
        
       static let playButton = CGPoint(x: General.viewWidth * 0.25, y: General.viewHeight * 0.45)
        
       static let multiplayerButton = CGPoint(x: General.viewWidth * 0.416667, y: General.viewHeight * 0.45)
        
        static let gameCenterButton = CGPoint(x: General.viewWidth * 0.583334 , y: General.viewHeight * 0.45)
        
        static let infoButton = CGPoint(x: General.viewWidth * 0.75, y: General.viewHeight * 0.45)
        
        
        
    }
    
}

struct GameImg {
    static let numberOfFrames = 4
    struct name {
        static let burger = "burger_1"
        static let apple = "apple_1"
        static let banana = "banana_1"
        static let broccoli = "broccoli_1"
        
        static let burger2 = "burger_2"
        static let apple2 = "apple_2"
        static let banana2 = "banana_2"
        static let broccoli2 = "broccoli_2"
        
        static let burger3 = "burger_2"
        static let apple3 = "apple_2"
        static let banana3 = "banana_2"
        static let broccoli3 = "broccoli_2"
        
        
        
 
    }

}

struct EndImg{
    
    
    struct name {
        static let replayButton = "replay"
        static let shareButton = "share"
        static let homeButton = "mainMenu"
        static let scoreCard = "Scorecard"
    }
    
    struct position {
        
        static let replayButton = CGPoint(
            x: General.viewWidth * 0.25 ,
            y: General.viewHeight * 0.35)
        
        static let shareButton = CGPoint(
            x: General.viewWidth/2 ,
            y: General.viewHeight * 0.35 )
        
        static let homeButton = CGPoint(
            x: General.viewWidth * 0.75 ,
            y: General.viewHeight * 0.35 )
        
        static let scoreCard = CGPoint(
            x: General.viewWidth/2 ,
            y: General.viewHeight * 0.9 )
        
    }
}



