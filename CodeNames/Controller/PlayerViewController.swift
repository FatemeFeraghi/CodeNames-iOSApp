//
//  PlayerViewController.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-04-07.
//

import UIKit

class PlayerViewController: UIViewController {

    private let bluePlayerPanel = BluePlayerPanel()
    private let redPlayerPanel = RedPlayerPanel()
    public var board : Board = Board(size: 25)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textColor = UIColor(named: "DarkGreen")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let btnStartGame: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Game", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "DarkGreen")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleStartGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()

    }
    
    //Appear the fields to join the game every time the view appears
    //or user clicks on back button
    override func viewWillAppear(_ animated: Bool) {
        bluePlayerPanel.btnBlueSpymaster.isHidden = false
        bluePlayerPanel.btnBlueOperative.isHidden = false
        bluePlayerPanel.blueOperativeName = ""
        bluePlayerPanel.blueSpymasterName = ""
        
        redPlayerPanel.btnRedOperative.isHidden = false
        redPlayerPanel.btnRedSpymaster.isHidden = false
        redPlayerPanel.redOperativeName = ""
        redPlayerPanel.redSpymasterName = ""
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureTitleLabel()
        
        view.addSubviews(titleLabel, bluePlayerPanel, redPlayerPanel, btnStartGame)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bluePlayerPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 12).isActive = true
        bluePlayerPanel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        bluePlayerPanel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true
        bluePlayerPanel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        
        redPlayerPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true
        redPlayerPanel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        redPlayerPanel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45).isActive = true
        redPlayerPanel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        
        btnStartGame.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        btnStartGame.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        btnStartGame.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
        btnStartGame.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        
    }
    
    func configureTitleLabel() {
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "💥CodeNames"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    @objc func handleStartGameButtonTapped() {

        let blueTeamPlayers = bluePlayerPanel.blueTeam.players
        let redTeamPlayers = redPlayerPanel.redTeam.players
        
        
        guard   blueTeamPlayers.count == 2,
                redTeamPlayers.count == 2
                
        else
        {
            btnStartGame.shake()
            return
        }


        let controller = MainViewController()
        navigationController?.pushViewController(controller, animated: true)
        controller.blueTeamPlayers = blueTeamPlayers
        controller.redTeamPlayers = redTeamPlayers
        controller.board = self.board
    }


}
