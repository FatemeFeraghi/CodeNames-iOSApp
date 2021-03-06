//
//  HeaderPanel.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation
import UIKit


class HeaderPanel: UIView {
    
    public let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.backgroundColor = UIColor(named: "LightGreen")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    public let lblBlueScore: UILabel = {
        let label = UILabel()
        label.text = "9"
        label.textColor = .white
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 21)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let lblRedScore: UILabel = {
        let label = UILabel()
        label.text = "8"
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        label.font = UIFont.systemFont(ofSize: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    private func initialize() {

        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(messageLabel, lblBlueScore, lblRedScore)

        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        
        messageLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.12).isActive = true
        
        
        lblBlueScore.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        lblBlueScore.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        lblBlueScore.topAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 10).isActive = true
        lblBlueScore.heightAnchor.constraint(equalTo: self.lblBlueScore.widthAnchor, multiplier: 0.25).isActive = true
        
        
        lblRedScore.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        lblRedScore.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3).isActive = true
        lblRedScore.topAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 10).isActive = true
        lblRedScore.heightAnchor.constraint(equalTo: self.lblRedScore.widthAnchor, multiplier: 0.25).isActive = true
    }
}
