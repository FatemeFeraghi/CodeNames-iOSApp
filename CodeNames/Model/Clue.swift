//
//  Clue.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation

struct Clue {
    
    let quantity: Int
    let word: String
    
    func validateClue(){
        
    }
    
    init(quantity: Int, word: String) {
        self.quantity = quantity
        self.word = word
    }
}
