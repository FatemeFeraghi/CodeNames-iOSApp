//
//  PlayerViewPanel.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-04-07.
//

import UIKit

class BluePlayerPanel: UIView {
    
    private var _blueOperativeName: String = ""
    private var _blueSpymasterName: String = ""
    
    public var blueTeam = Team(players: [], hasSpymaster: false, color: .Blue)
    
    private let txtNameBlueOperative: CustomTextField = {
        let tf = CustomTextField(placeholder: "Name")
        tf.keyboardType = .emailAddress
        tf.textColor = .black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let txtNameBlueSpymaster: CustomTextField = {
        let tf = CustomTextField(placeholder: "Name")
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .none
        tf.textColor = .black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let btnBlueOperative: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join as operative", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBlueOperativeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let btnBlueSpymaster: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join as spymaster", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBlueSpymasterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public var blueOperativeName : String {
        get {
            return self._blueOperativeName
        }
        set(newValue) {
            self._blueOperativeName = newValue
            self.txtNameBlueOperative.text = newValue
        }
    }
    
    public var blueSpymasterName : String {
        get {
            return self._blueSpymasterName
        }
        set(newValue) {
            self._blueSpymasterName = newValue
            self.txtNameBlueSpymaster.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleBlueOperativeButtonTapped() {
        
        guard let name : String = txtNameBlueOperative.text else { return }
        
        if name == "" {
            txtNameBlueOperative.shakeWith(btnBlueOperative)
        } else {
            btnBlueOperative.isHidden = true
            txtNameBlueOperative.text = "Operative: " + name
            blueTeam.players.append(Player(id: 1, name: name, role: "operative"))
        }
    }
    
    @objc func handleBlueSpymasterButtonTapped() {
        
        guard let name : String = txtNameBlueSpymaster.text else { return }
        
        if name == "" {
            txtNameBlueSpymaster.shakeWith(btnBlueSpymaster)
        } else {
            btnBlueSpymaster.isHidden = true
            txtNameBlueSpymaster.text = "Spymaster: " + name
            blueTeam.players.append(Player(id: 2, name: name, role: "spymaster"))
        }
    }
    
    func initialize() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(txtNameBlueSpymaster,
                    txtNameBlueOperative,
                    btnBlueOperative,
                    btnBlueSpymaster)

//        self.backgroundColor = .systemTeal
        self.backgroundColor = .none

        applyConstraints()
        
        txtNameBlueOperative.text = self._blueOperativeName
        txtNameBlueSpymaster.text = self._blueSpymasterName
    }
    
    private func applyConstraints() {
        
        txtNameBlueOperative.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        txtNameBlueOperative.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        txtNameBlueOperative.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnBlueOperative.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        btnBlueOperative.topAnchor.constraint(equalTo: self.txtNameBlueOperative.bottomAnchor, constant: 10).isActive = true
        btnBlueOperative.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        btnBlueOperative.heightAnchor.constraint(equalTo: self.btnBlueOperative.widthAnchor, multiplier: 0.3).isActive = true

        
        txtNameBlueSpymaster.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        txtNameBlueSpymaster.bottomAnchor.constraint(equalTo: self.btnBlueSpymaster.topAnchor, constant: -10).isActive = true
        txtNameBlueSpymaster.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        btnBlueSpymaster.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        btnBlueSpymaster.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        btnBlueSpymaster.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        btnBlueSpymaster.heightAnchor.constraint(equalTo: self.btnBlueOperative.widthAnchor, multiplier: 0.3).isActive = true
        
    }

}
