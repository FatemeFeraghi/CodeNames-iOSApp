//
//  Board.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation

struct Board {
    var size: Int
    var cards: [Card]
    var key: [Int]
    
    init(size: Int, cards: [Card], key: [Int]) {
        self.size =  size
        self.cards = cards
        self.key = key
    }
    
    func assignKey(size: Int) {
        
    }
    
    func setCards(key: [Int], cards: [Card]) {
        
    }
    
    func createBoard(size: Int) {

    }
}
