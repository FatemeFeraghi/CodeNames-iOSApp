//
//  GameLogPanel.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import UIKit

class GameLogPanel: UIView {
    
    private let gameLogLabel: UILabel = {
        let label = UILabel()
        label.text = "Game Log:"
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
        addSubviews(gameLogLabel)

        self.backgroundColor = .blue.withAlphaComponent(0.1)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        
        gameLogLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gameLogLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        gameLogLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        gameLogLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
}
