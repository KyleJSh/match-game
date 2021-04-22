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
        
        if card.isMatched == true {
            
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            // already matched, exit method
            return
            
        }
        else {
            
            // if not matched, make sure both images visible
            backImageView.alpha = 1
            frontImageView.alpha = 1
            
        }
        
        // reset state of cell by checking flipped status
        if card.isFlipped == true {
            
            flipUp(speed: 0)
        }
        else {
            
            // show back image view
            flipDown(speed: 0, delay: 0)
        }
        
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        // flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        // update flipped status of card
        card?.isFlipped = true
        
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay:TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            // flip down animation
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        }
        
        // update flipped status
        card?.isFlipped = false
        
    }
 
    func remove() {
        
        // remove backimageview immediately
        backImageView.alpha = 0
        
        // apply animation to the front image views to user can see them fading
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontImageView.alpha = 0
            
        }, completion: nil)
    }
}
