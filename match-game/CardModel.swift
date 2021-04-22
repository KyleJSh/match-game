//
//  CardModel.swift
//  match-game
//
//  Created by Kyle Sherrington on 2021-04-19.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        // declare an empty array
        var generatedCards = [Card]()
        
        // store random numbers
        var generatedNumbers = [Int]()
        
        // randomly generate 8 pairs of cards
        while generatedNumbers.count < 8 {
            
            // generate random number
            let randomNum = Int.random(in: 1...13)
            
            // create 2 new card objects
            let cardOne = Card()
            let cardTwo = Card()
            
            cardOne.imageName = "card\(randomNum)"
            cardTwo.imageName = "card\(randomNum)"
            
            // add to the array
            generatedCards += [cardOne, cardTwo]
            generatedNumbers.append(randomNum)
            
            // print random numbers to console
            print(randomNum)
            
            // shuffle array
            generatedCards.shuffle()
            
        }
        
        return generatedCards
        
    }
    
}
