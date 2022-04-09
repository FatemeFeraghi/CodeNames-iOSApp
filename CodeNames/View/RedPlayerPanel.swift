//
//  RedPlayerPanel.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-04-07.
//

import UIKit

class RedPlayerPanel: UIView {

    private var _redOperativeName: String = ""
    private var _redSpymasterName: String = ""
    
    private let txtNameRedOperative: CustomTextField = {
        let tf = CustomTextField(placeholder: "Name")
        tf.keyboardType = .emailAddress
        tf.textColor = .black
        tf.backgroundColor = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let txtNameRedSpymaster: CustomTextField = {
        let tf = CustomTextField(placeholder: "Name")
        tf.keyboardType = .emailAddress
        tf.textColor = .black
        tf.backgroundColor = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let btnRedOperative: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join as operative", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .red
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRedOperativeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let btnRedSpymaster: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join as spymaster", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .red
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRedSpymasterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public var redOperativeName : String {
        get {
            return self._redOperativeName
        }
        set(newValue) {
            self._redOperativeName = newValue
            self.txtNameRedOperative.text = newValue
        }
    }
    
    public var redSpymasterName : String {
        get {
            return self._redSpymasterName
        }
        set(newValue) {
            self._redSpymasterName = newValue
            self.txtNameRedSpymaster.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleRedOperativeButtonTapped() {
        
        guard let name : String = txtNameRedOperative.text else { return }
        
        if name == "" {
            txtNameRedOperative.shakeWith(btnRedOperative)
        } else {
            btnRedOperative.isHidden = true
            txtNameRedOperative.text = "Operative: " + name
        }
    }
    
    @objc func handleRedSpymasterButtonTapped() {
        
        guard let name : String = txtNameRedSpymaster.text else { return }
        
        if name == "" {
            txtNameRedSpymaster.shakeWith(btnRedSpymaster)
        } else {
            btnRedSpymaster.isHidden = true
            txtNameRedSpymaster.text = "Spymaster: " + name
        }
    }
    
    func initialize() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(txtNameRedOperative,
                    txtNameRedSpymaster,
                    btnRedSpymaster,
                    btnRedOperative)

//        self.backgroundColor = UIColor(named: "darkRed")
        self.backgroundColor = .none
        applyConstraints()
        
        txtNameRedOperative.text = self._redOperativeName
        txtNameRedSpymaster.text = self._redSpymasterName
    }
    
    private func applyConstraints() {
        
        txtNameRedOperative.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        txtNameRedOperative.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        txtNameRedOperative.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnRedOperative.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        btnRedOperative.topAnchor.constraint(equalTo: self.txtNameRedOperative.bottomAnchor, constant: 10).isActive = true
        btnRedOperative.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnRedOperative.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        txtNameRedSpymaster.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        txtNameRedSpymaster.bottomAnchor.constraint(equalTo: self.btnRedSpymaster.topAnchor, constant: -10).isActive = true
        txtNameRedSpymaster.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnRedSpymaster.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        btnRedSpymaster.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        btnRedSpymaster.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnRedSpymaster.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        
    }

}


