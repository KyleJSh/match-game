//
//  SoundManager.swift
//  match-game
//
//  Created by Kyle Sherrington on 2021-04-21.
//


import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        
        case shuffle
        case flip
        case match
        case win
        case lose
        
    }
    
    func playSound(effect:SoundEffect) {
        
        var soundFilename = ""
        
        switch effect {
        
        case .shuffle:
            soundFilename = "shuffleCards"
            
        case .flip:
            soundFilename = "cardFlip"
            
        case .match:
            soundFilename = "match"
            
        case .win:
            soundFilename = "gameWin"
        case .lose:
            soundFilename = "gameLose"
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: ".mp3")
        
        guard bundlePath != nil else {
            // couldn't find resource
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            // try and play sound
            audioPlayer?.play()
            
        }
        catch {
            // couldn't retrieve sound
            print("Couldn't get sound")
            return
        }
    }
}
