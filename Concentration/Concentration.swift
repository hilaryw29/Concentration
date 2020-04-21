//
//  Concentration.swift
//  Concentration
//
//  Created by Hilary Wang on 2020-03-14.
//  Copyright © 2020 Hilary Wang. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    //optional var will be nil when there is NOT only 1 card face up
    var  indexOfOneAndOnlyFaceUpCard : Int?
    
    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if  cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                flipAllDown()
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func flipAllDown () {
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
        }
    }
    
    init (numberOfPairsOfCards : Int) {
        for _ in 0..<numberOfPairsOfCards {
            //There are three "Card"s being created here
            //card #1
            let card = Card()
            //card #2 - a copy of card is put into the array
            cards.append(card)
            //card #3 - another copy of card is put into the array
            cards.append(card)
            
            /*Another version of adding cards to arrays
            cards += [card, card]
            */
        }
        
        //TODO: Shuffle the cards (homework)
        cards.shuffle()
        
    }
}
