//
//  Sound.swift
//  HungryJUJU
//
//  Created by Ghadeer Alkhathlan on 1/8/17.
//  Copyright © 2017 Ghadeer Alkhathlan. All rights reserved.
//

import SpriteKit
import AVFoundation

private let SoundInstance = Sound()

open class Sound {
    
    open class func sharedInstance() -> Sound { return SoundInstance}
    
    //MARK: - Music
    fileprivate var musicPlayer: AVAudioPlayer?
    
    open func playMusic() {
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "background.mp3", withExtension: nil)!)
            musicPlayer!.numberOfLoops = -1
            musicPlayer!.prepareToPlay()
            
            if UserDefaults.standard.bool(forKey: "PlayMusic") {
                musicPlayer!.play()
            }
        } catch {
            print("cann't create AVAudioPlayer")
        }
    }
    
    fileprivate func pauseMusic() {
        if musicPlayer!.isPlaying {
            musicPlayer!.pause()
        }
    }
    
    fileprivate func resumeMusic() {
        if !musicPlayer!.isPlaying {
            musicPlayer!.play()
        }
    }
    
    open func changeMusicState() {
        
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlayMusic"), forKey: "PlayMusic")
        
        if UserDefaults.standard.bool(forKey: "PlayMusic") { resumeMusic()}
        else { pauseMusic()}
    }
    
    //MARK: - Sounds
    open var sceneForPlayingSounds: SKScene?
    
    /**
     Enum with list of possible sounds.
     */
    public enum name {
        case buttonPress
        case getPoint
    }
    
    //Preloaded sounds action for scene
    internal let buttonPress = SKAction.playSoundFileNamed("buttonPress.mp3", waitForCompletion: false)
    internal let getPoint = SKAction.playSoundFileNamed("getPoint.mp3", waitForCompletion: false)
    
    /**
     It's interface for playing sounds.
     */
    open func playSound(_ name: name) {
        if UserDefaults.standard.bool(forKey: "PlaySounds") {
            switch name {
            case .buttonPress:
                sceneForPlayingSounds?.run(Sound.sharedInstance().buttonPress)
            case .getPoint:
                sceneForPlayingSounds?.run(Sound.sharedInstance().getPoint)
            }
        }
        else {
            print("Sound class: Class not have output object for playing sound")
        }
    }
    
    /**
     Change settings of sounds. Possible to play or not
     */
    open func changeSoundState() {
        UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "PlaySounds"), forKey: "PlaySounds")
    }
}

