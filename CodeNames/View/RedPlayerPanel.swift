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
    
    private let txtNameOperative: CustomTextField = {
        let tf = CustomTextField(placeholder: "Name")
        tf.keyboardType = .emailAddress
        tf.textColor = .black
        tf.backgroundColor = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let txtNameSpymaster: CustomTextField = {
        let tf = CustomTextField(placeholder: "Name")
        tf.keyboardType = .emailAddress
        tf.textColor = .black
        tf.backgroundColor = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let btnOperative: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join as operative", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .red
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleOperativeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let btnSpymaster: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join as spymaster", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .red
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSpymasterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public var redOperativeName : String {
        get {
            return self._redOperativeName
        }
        set(newValue) {
            self._redOperativeName = newValue
            self.txtNameOperative.text = newValue
        }
    }
    
    public var redSpymasterName : String {
        get {
            return self._redSpymasterName
        }
        set(newValue) {
            self._redSpymasterName = newValue
            self.txtNameSpymaster.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleOperativeButtonTapped() {
        
        guard let name : String = txtNameOperative.text else { return }
        
        if name == "" {
            txtNameOperative.shakeWith(btnOperative)
        } else {
            btnOperative.isHidden = true
            txtNameOperative.text = "Operative: " + name
        }
    }
    
    @objc func handleSpymasterButtonTapped() {
        
        guard let name : String = txtNameSpymaster.text else { return }
        
        if name == "" {
            txtNameSpymaster.shakeWith(btnOperative)
        } else {
            btnSpymaster.isHidden = true
            txtNameSpymaster.text = "Spymaster: " + name
        }
    }
    
    func initialize() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(txtNameOperative,
                    txtNameSpymaster,
                    btnOperative,
                    btnSpymaster)

//        self.backgroundColor = UIColor(named: "darkRed")
        self.backgroundColor = .none
        applyConstraints()
        
        txtNameOperative.text = self._redOperativeName
        txtNameSpymaster.text = self._redSpymasterName
    }
    
    private func applyConstraints() {
        
        txtNameOperative.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        txtNameOperative.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        txtNameOperative.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnOperative.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        btnOperative.topAnchor.constraint(equalTo: self.txtNameOperative.bottomAnchor, constant: 10).isActive = true
        btnOperative.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnOperative.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        txtNameSpymaster.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        txtNameSpymaster.bottomAnchor.constraint(equalTo: self.btnSpymaster.topAnchor, constant: -10).isActive = true
        txtNameSpymaster.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnSpymaster.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        btnSpymaster.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        btnSpymaster.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btnSpymaster.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        
    }

}


