//
//  File.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation

enum Color: Int {
    case RED
    case BLUE
    case BLACK
    case PALE
    
    var ColorMessage: String {
        switch self {
        case .RED: return "Red Team"
        case .BLUE: return "Blue Team"
        case .BLACK: return "Assassin"
        case .PALE: return "Bystander"
        }
    }
}
