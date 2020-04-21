//
//  Card.swift
//  Concentration
//
//  Created by Hilary Wang on 2020-03-14.
//  Copyright © 2020 Hilary Wang. All rights reserved.
//

import Foundation

struct Card {
    //non static variables stored with each individual card
    var isFaceUp = false
    var isMatched  = false
    var identifier : Int
    
    //static variables are stored with the TYPE Card
    static var identifierFactory = 0
    
    //static functions cannot be sent to an individual object "Card"
    //only the Card TYPE will be able to call this function
    static func getUniqueIdentifier () -> Int {
        //In a static method, you can access static vars without Card.
        identifierFactory += 1
        return identifierFactory
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }
}
