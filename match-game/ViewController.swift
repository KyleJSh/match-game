//
//  ViewController.swift
//  match-game
//
//  Created by Kyle Sherrington on 2021-04-19.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Variables and Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardsArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardsArray = model.getCards()

    }

    // MARK: - Game Logic Methods

    func checkForMatch(_ secondFlippedCardIndex:IndexPath) {
        
        // get the two card objects for the two indices and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            // it's a match, set status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // remove cards
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
        }
        else {
            
            // set the state
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // cards are not a match
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
        }
        
        // reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
    
}

// MARK: - Collection View Methods
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // reuse cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // get card from array
        let card = cardsArray[indexPath.row]
        
        // finish configuring cell
        cell.configureCell(card: card)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get reference to cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if cell?.card?.isFlipped == false {
            
            // flip up
            cell?.flipUp()
            
            // check if this is the first flipped card
            if firstFlippedCardIndex == nil {
                
                // this is the first flipped card
                firstFlippedCardIndex = indexPath
                
            }
            else {
                
                // this is the second flipped card
                // run comparison logic
                checkForMatch(indexPath)
            }
            
        }
        else {
            
            
            
        }
        
    }
    
}
