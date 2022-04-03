//
//  HeaderPanel.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation
import UIKit


class HeaderPanel: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    private func initialize() {

        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(messageLabel)

        self.backgroundColor = UIColor(named: "beige")

        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        
        messageLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
