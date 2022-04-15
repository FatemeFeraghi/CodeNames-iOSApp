//
//  Board.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation


class Board {
    var size: Int
    var cards: [Card]
    var key: [Int]
    
    //Variables with hard coded proportions of cards for a 25-card board size
    var reds = 8
    var blues = 9
    var assassin = 1
    var bystanders = 7
    
    //Hard coded list of cards
    var listOfCards: [(Card)] = [
            Card(color: .Black, word: "Fateme"),
            Card(color: .Black, word: "Urum"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus"),
            Card(color: .Black, word: "Matheus")

        ]
    
    init(size: Int) {
        self.size =  size
        self.key = [size]
        
        //Call API to set the list of Cards with the required amount here.
        self.cards = listOfCards
        
        //Call function to randomically distribute the cards
        self.assignKey(size: size)
    }
    func setSize(size : Int)
    {
        self.size = size
    }
    func assignKey(size: Int) {
        
        //Counter variables
        var redsCounter = 0
        var bluesCounter = 0
        var assassinCounter = 0
        var bystandersCounter = 0
        
        for card in self.cards {
            var isCorrect : Bool = false
            repeat{
                isCorrect = false
                let listOfColors : [CardColor] = [.Red, .Blue, .Black, .Pale]
                let randomColor = listOfColors.shuffled()[0]
                switch randomColor
                {
                    case .Red:
                        if(redsCounter < reds)
                        {
                            card.color = randomColor
                            redsCounter += 1
                            isCorrect = true
                        }
                        break
                    case .Blue:
                        if(bluesCounter < blues)
                        {
                            card.color = randomColor
                            bluesCounter += 1
                            isCorrect = true
                        }
                        break
                    case .Black:
                        if(assassinCounter < assassin)
                        {
                            card.color = randomColor
                            assassinCounter += 1
                            isCorrect = true
                        }
                        break
                    case .Pale:
                        if(bystandersCounter < bystanders)
                        {
                            card.color = randomColor
                            bystandersCounter += 1
                            isCorrect = true
                        }
                        break
                    default:
                        break
                }
                
            }while(isCorrect == false)
        }
        
        

        
    }
    
    func setCards(key: [Int], cards: [Card]) {
        
    }
    
    func createBoard(size: Int) {

    }
}
