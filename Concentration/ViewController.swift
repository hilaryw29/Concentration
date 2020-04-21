//
//  ViewController.swift
//  Concentration
//
//  Created by Hilary Wang on 2020-03-11.
//  Copyright © 2020 Hilary Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var flipCount = 0 {
        didSet  {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
        
    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet var newGameButton: UIButton!
    
    @IBAction func hitReset (_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
        flipCount = 0
        emoji.removeAll()
        initializeThemes()
        game.flipAllDown()
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    //" _ " is done when there is no argument, not typically used
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if  let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            //if the button is not connected to cardButtons
            print ("chosen card not in cardButtons")
        }
        
    }
    
    override func viewDidLoad() {
        initializeThemes()
    }
    
    func updateViewFromModel () {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card  = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
    }
    
    
    //TODO: add themes 
    var emojiChoices = [[String]]()
    var currentTheme = Int()
    
    func initializeThemes () {
        emojiChoices.removeAll()
        emojiChoices.append(["🦇", "👻","🎃" ,"🙀", "😱", "🍭", "😈", "🍬"])
        emojiChoices.append(["❄️", "⛄️", "🥶", "⛷", "🏂", "🎄", "🎅", "🌟"])
        emojiChoices.append(["🏀", "🏈", "🏏", "🏐", "🏓", "⚾️", "🎾", "🏸"])
        emojiChoices.append(["🦙", "🦛", "🦥", "🦩", "🐘", "🦚", "🦞", "🦡"])
        currentTheme = Int.random(in: 0..<emojiChoices.count)
    }
    
    //Dictionary that stores the id for the card and its corresponding emoji
    var emoji = Dictionary<Int, String>()
    
    //Look in dictionary and get a card
    func emoji (for card: Card) -> String {
        //if there is no emoji currently associated with the card id, and we have not used all our emojis, assign one of the...
        //... remaining emojis in our emojiChoices array to the current card.
        //we also need the "if" because Dictionary returns an Optional (not purely String) since the value we're looking for might not exist
        if emoji[card.identifier] == nil, emojiChoices[currentTheme].count > 0 {
                //generates random index value within our remaining emojiChoices array, assigns random emoji to this card
            let randomIndex = Int.random(in: 0..<emojiChoices[currentTheme].count)
                emoji[card.identifier] = emojiChoices[currentTheme].remove(at: randomIndex)
        }
        
        //if nil, return "?", same as commented code below
        return emoji[card.identifier] ?? "?"
        
    }
    
}
