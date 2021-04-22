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
    @IBOutlet weak var timerLabel: UILabel!
    
    var model = CardModel()
    var cardsArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var milliseconds:Int = 10 * 1000
    
    var soundPlayer = SoundManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardsArray = model.getCards()
        
        // initialize timer
        timer = Timer.scheduledTimer(timeInterval: 1/1000, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
        soundPlayer.playSound(effect: .shuffle)
    }
    
    // MARK: - Timer Methods
    @objc func timerFired() {
        
        // decrement the timer
        milliseconds -= 1
        
        // update the label
        let seconds:Double = Double(milliseconds)/1000.0
        
        // % is wild card, and .2f is expressed in 2 decimal places
        timerLabel.text = String(format: "Time Remaining: %.2f", seconds)
        
        // stop the timer if it reaches zero
        if milliseconds == 0 {
            
            // update timer label to notify user
            timerLabel.textColor = UIColor.red
            
            // call invalidate method on timer
            timer?.invalidate()
            
        }
        
        // TODO: check if user has cleared all the pairs
        checkForGameEnd()
        
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
            
            // play is matched sound
            soundPlayer.playSound(effect: .match)
            
            // remove cards
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // check if user has cleared all the pairs
            checkForGameEnd()
            
        }
        else {
            
            // set the state
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // play no match sound
            soundPlayer.playSound(effect: .nomatch)
            
            // cards are not a match
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
            
        }
        
        // reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
    
    func checkForGameEnd() {
        
        var hasWon = true
        
        for card in cardsArray {
            
            if card.isMatched == false {
                
                // we've found a card that is unmatched
                hasWon = false
                
                // kill loop
                break
                
            }
            
        }
        
        if hasWon == true {
            
            // user has won, show some sort of pop up dialog
            showAlert(title: "Congratulations", message: "You've won the game!")
        }
        else {
            
            // user hasn't won, check if there's time left
            if milliseconds <= 0 {
                
                showAlert(title: "Time's Up!", message: "Sorry, better luck next time")
                
            }
            
        }
        
    }
    
    func showAlert(title:String, message:String) {
        
        // create alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // create UIAlertAction object
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        // button needs to be added to alert
        alert.addAction(okAction)
        
        // present alert
        present(alert, animated: true, completion: nil)
        
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
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // try to cast
        let cardCell = cell as? CardCollectionViewCell
        
        // get card from array
        let card = cardsArray[indexPath.row]
        
        // finish configuring cell
        cardCell?.configureCell(card: card)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // disallow user to interact with the cards once timer has run out
        if milliseconds <= 0 {
            return
        }
        
        // get reference to cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            
            // flip up
            cell?.flipUp()
            
            // play flip up sound
            soundPlayer.playSound(effect: .flip)
            
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
        
    }
    
}
