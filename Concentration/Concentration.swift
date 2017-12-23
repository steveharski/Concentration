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
    
    var flippedCardsIDs = [Int]()
    
    var score = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    var faceUpCardID: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // append id of flipped card
                flippedCardsIDs.append(cards[index].identifier)
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    // +2 points
                    score += 2
                } else {
                    // check if penalty needed
                    updateScore(for: [faceUpCardID!, cards[index].identifier])
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
                // get id of flipped card
                faceUpCardID = cards[index].identifier
                // append id of flipped card
                flippedCardsIDs.append(faceUpCardID!)
            }
        }
    }
    
    private func updateScore(for cardsIDs: [Int]) {
        for id in cardsIDs {
           score -= (flippedCardsIDs.filter{$0 == id}.count - 1) >= 1 ? 1 : 0
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] //different cards, cause struct gets copied
        }
        // TODO: Shuffle the cards
        /*
        for cardIndex in 0..<cards.count {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count - 1)))
            cards.swapAt(cardIndex, randomIndex) 
        }*/
    }
    
    
    
}
