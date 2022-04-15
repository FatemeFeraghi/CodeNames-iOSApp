//
//  CardCell.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-28.
//

import Foundation
import UIKit

protocol CardCellDelegate: class {
    func didTapWordButtonIn(_ card: Card)
}

class CardCell: UICollectionViewCell {
    
    var card: Card? {
        didSet { self.configure() }
    }
    
    weak var delegate: CardCellDelegate?
    
    private let cardImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let wordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("word", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleWordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.tintColor = .black
        label.backgroundColor = .green
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .white
        divider.tintColor = .black
        return divider
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    private func initialize() {

        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(cardImageView, wordButton, label, divider)

        self.backgroundColor = UIColor(named: "beige")

        applyConstraints()
    }
    
    @objc func handleWordButtonTapped() {
        guard let card = card else { return }
        delegate?.didTapWordButtonIn(card)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints() {
        
        
        label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -5).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        cardImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant:  -5).isActive = true
        cardImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cardImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        cardImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        divider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.cardImageView.trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        wordButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        wordButton.leadingAnchor.constraint(equalTo: divider.leadingAnchor, constant: 5).isActive = true
        wordButton.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor).isActive = true
        wordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func configure() {
        guard let card = card else { return }
        
        wordButton.setTitle(card.word, for: .normal)
        self.backgroundColor = card.color.toUIColor()
    }
}
