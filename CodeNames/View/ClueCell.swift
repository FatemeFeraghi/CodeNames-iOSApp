//
//  ClueCell.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-04-09.
//

import Foundation
import UIKit

protocol GiveClueDelegate: class {
    func spymasterDidGiveClue(_ clue: Clue)
}

class ClueCell: UIView {
    
    weak var delegate: GiveClueDelegate?
    
    public let txtWordClue: CustomTextField = {
        let tf = CustomTextField(placeholder: "Type your clue here..")
        tf.keyboardType = .emailAddress
        tf.textColor = .black
        tf.backgroundColor = UIColor(named: "LightGrey")
        tf.layer.cornerRadius = 10
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    public let txtQuantityClue: CustomTextField = {
        let tf = CustomTextField(placeholder: "-")
        tf.keyboardType = .phonePad
        tf.textColor = .black
        tf.backgroundColor = UIColor(named: "LightGrey")
        tf.layer.cornerRadius = 10
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let giveClueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Give Clue", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "LightGreen")
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleGiveClueButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    private func initialize() {

        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(txtWordClue, txtQuantityClue, giveClueButton)

        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleGiveClueButtonTapped() {
        guard let word = txtWordClue.text, txtWordClue.text != "" else {
            txtWordClue.shakeWith(giveClueButton)
            return
        }
        guard let quantity = txtQuantityClue.text, txtQuantityClue.text != "" else {
            txtQuantityClue.shakeWith(giveClueButton)
            return
        }
        let clue = Clue(quantity: Int(quantity)!, word: word)
        delegate?.spymasterDidGiveClue(clue)
    }
    
    private func applyConstraints() {
        
        txtWordClue.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        txtWordClue.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.55).isActive = true
        txtWordClue.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        txtWordClue.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        txtQuantityClue.leadingAnchor.constraint(equalTo: self.txtWordClue.trailingAnchor, constant: 10).isActive = true
        txtQuantityClue.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.10).isActive = true
        txtQuantityClue.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        txtQuantityClue.heightAnchor.constraint(equalTo: self.txtQuantityClue.widthAnchor).isActive = true
        
        giveClueButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        giveClueButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.2).isActive = true
        giveClueButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        giveClueButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}
