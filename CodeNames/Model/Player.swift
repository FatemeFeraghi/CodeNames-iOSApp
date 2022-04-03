//
//  Player.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation

enum RoleType: Int {
    case SPYMASTER
    case OPERATIVE
    
    var roleMessage: String {
        switch self {
        case .SPYMASTER: return ""
        case .OPERATIVE: return ""
        }
    }
}

class Player {
    let id: Int
    let name: String
    var role: RoleType
    
    func giveClue() -> String{
        return ""
    }
    
    func tapCard() {
        
    }
    
    func endGuess() {
        
    }
    
    init(id: Int, name: String, role: RoleType) {
        self.id = id
        self.name = name
        self.role = role
    }
}
