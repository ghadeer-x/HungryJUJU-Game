//
//  Settings.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit

struct General {
    
    static let viewWidth:CGFloat  = 1536
    static let viewHeight:CGFloat  = 2048
    static let backgroundColor = UIColor(red: 52.0/255.0, green: 134/255.0, blue: 126/255.0, alpha: 1.0)
    
    static let transitionSpeed: Double = 0.8
    static let fontName: String = ".SFUIDisplay-Light"
    
    struct GameCenter {
        static let leaderboard = "Leaderboard"
    }
    
    struct SomeSocialStats {
        static let shareText = "Try to beat my score!"
        static let linkToRateUs = "http://google.com/"
    }
    
    struct fontSize {
        static let labelScore: CGFloat = 65
        static let labelCoins: CGFloat = 20
    }
    
    struct fontColor {
        static let labelScore = "#87a9a6"
        static let labelCoins = "#87a9a6"
    }
    /*Ads settings */
    
}



// Image Settings

struct Img {
    
    struct name {
        static let kitchen = "kitchen"
        static let table = "table"
        static let buttonStart_simple = "singleMode"
        static let buttonStart_pressed = "info"
    }
    
    struct position {
        static let kitchen = CGPoint(x:General.viewWidth/2, y:  General.viewHeight * 0.80 )
        static let table = CGPoint.zero
        static let buttonStart = CGPoint(x: General.viewWidth * 0.25, y: General.viewHeight * 0.45)
    }
    
    struct zPosition {
        static let kitchen: CGFloat = 0
        static let table: CGFloat = 1
        static let buttonStart: CGFloat = 1
    }
    
    
}

