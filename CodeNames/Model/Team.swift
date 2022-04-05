//
//  Team.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation

struct Team {
    var players: [Player]
    var hasSpymaster: Bool?
    var color: CardColor
    
    init(players: [Player], hasSpymaster: Bool, color: CardColor) {
        self.players =  players
        self.hasSpymaster = hasSpymaster
        self.color = color
    }
    
}
