//
//  Extensions.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-28.
//

import UIKit

extension UIView {
    
    func addSubviews ( _ subviews : UIView... ) {
        
        for subview in subviews {
            self.addSubview(subview)
        }
        
    }
    
}

