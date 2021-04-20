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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardsArray = model.getCards()

    }

    // MARK: - Methods

}

// MARK: - Collection View Methods
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
        // TODO: Configure cell
        
        return cell
        
    }
    
    
}
