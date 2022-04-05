//
//  Player.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation

class Player {
    let id: Int
    let name: String
    var role: String
    
    func giveClue() -> String{
        return ""
    }
    
    func tapCard() {
        
    }
    
    func endGuess() {
        
    }
    
    init(id: Int, name: String, role: String) {
        self.id = id
        self.name = name
        self.role = role
    }
}
