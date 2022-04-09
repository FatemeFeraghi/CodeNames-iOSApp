//
//  Card.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation
import UIKit

class Card {
    var color: CardColor
    var word: String
    
    init(color: CardColor, word: String) {
        self.color =  color
        self.word = word
    }
    func setColor(color : CardColor)
    {
        self.color = color
    }
}
