//
//  CustomTextField.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-04-07.
//

import UIKit


class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
                                                    [.foregroundColor: UIColor.black.withAlphaComponent(0.5)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
