//
//  GameLogPanel.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import UIKit

class GameLogPanel: UIView {
    
    public var gameLogLabel: UITextView = {
        let tv = UITextView()
        tv.alpha = 1.0
        tv.text = "Game Log:"
        tv.textColor = .black
        tv.textAlignment = .center
        tv.font = UIFont.boldSystemFont(ofSize: 14)
        tv.backgroundColor = UIColor(named: "LightGrey")
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    private func initialize() {

        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(gameLogLabel)

        self.backgroundColor = UIColor(named: "LightGreen")
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        
        gameLogLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        gameLogLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        gameLogLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        gameLogLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant:  -20).isActive = true
        
    }
}
