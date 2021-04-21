//
//  CardCollectionViewCell.swift
//  match-game
//
//  Created by Kyle Sherrington on 2021-04-19.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func configureCell (card:Card) {
        
        self.card = card
        
        // set front image view to the image this card represents
        frontImageView.image = UIImage(named: card.imageName)
        
        // reset state of cell by checking flipped status
        if card.isFlipped == true {
            
            flipUp(speed: 0)
        }
        else {
            
            // show back image view
            flipDown()
        }
        
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        // flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        // update flipped status of card
        card?.isFlipped = true
        
    }
    
    func flipDown(speed: TimeInterval = 0.3) {
        
        // flip down animation
        UIView.transition(from: frontImageView, to: backImageView, duration: speed, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        
        // update flipped status
        card?.isFlipped = false
        
    }
    
}
