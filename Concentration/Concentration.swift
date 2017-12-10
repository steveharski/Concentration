//
//  Concentration.swift
//  Concentration
//
//  Created by Adminaccount on 12/6/17.
//  Copyright © 2017 Steve Harski. All rights reserved.
//

import Foundation

class Concentration
{    
    var cards = [Card]()
    var shuffledCards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //different cards, cause struct gets copied
        }
        // TODO: Shuffle the cards
        for cardIndex in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count - 1)))
            cards.swapAt(cardIndex, randomIndex) 
        }
    }
    
    
    
}
