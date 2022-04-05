//
//  File.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation
import UIKit

enum CardColor {
    case Red
    case Blue
    case Black
    case Pale
    
    func toUIColor() -> UIColor {
        switch self {
        case .Red:
            return UIColor.red
        case .Blue:
            return UIColor.blue
        case .Black:
            return UIColor.black
        case .Pale:
            return UIColor.lightGray
        }
    }
   
}
