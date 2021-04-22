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
        
        case flip
        case match
        case nomatch
        case shuffle
        
    }
    
    func playSound(effect:SoundEffect) {
        
        var soundFilename = ""
        
        switch effect {
        
        case .flip:
            soundFilename = "cardflip"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"
            
        case .shuffle:
            soundFilename = "shuffle"
        }
        
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: ".wav")
        
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
