//
//  MainViewController.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-28.
//

import UIKit

private let cardCellIdentifier = "CardCell"

class MainViewController: UIViewController, CardCellDelegate, GiveClueDelegate {
    
    private let headerPanel = HeaderPanel()
    private let clueCellPanel = ClueCell()

    public var board : Board?
    private var isSpymaster = true
    private var isBlueTeam = false
    
    public var blueTeamPlayers : [Player] = []
    public var redTeamPlayers : [Player] = []
    
//    lazy var blueTeam = Team(players: blueTeamPlayers, hasSpymaster: true, color: .Blue)
//    lazy var redTeam = Team(players: redTeamPlayers, hasSpymaster: true, color: .Red)
    
    private var blueScore = 9
    private var redScore = 8
    private var numbers = [Int]()
    private let clue : Clue = Clue()
    private var isTurnOver = false
    private var numberOfGuesses: Int = 0

    var messageLabelIsHidden: Bool {
        return (isSpymaster == false) ? true : false
    }
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(CardCell.self, forCellWithReuseIdentifier: cardCellIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let gameLogPanel = GameLogPanel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        changeViewColor()
        self.headerPanel.messageLabel.backgroundColor = .blue
        
        clueCellPanel.delegate = self
        headerPanel.messageLabel.text = displayMessageLabel(clue: clue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.board!.assignKey(size: 3)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "CodeNames"
    
        view.addSubviews(headerPanel, collectionView, gameLogPanel, clueCellPanel)
        
        headerPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerPanel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.headerPanel.topAnchor, constant: 140).isActive = true
        
        clueCellPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        clueCellPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        clueCellPanel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        clueCellPanel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 5).isActive = true
        
        gameLogPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameLogPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameLogPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        gameLogPanel.topAnchor.constraint(equalTo: self.clueCellPanel.bottomAnchor, constant: 35).isActive = true
        
    }
    
    //Function to alternate spymaster boolean value
    @objc func changeSpymasterDebug()
    {
        self.isSpymaster = !(self.isSpymaster)
        self.collectionView.reloadData()
    }
    
    private func resetViewsWhenTurnOver() {
        self.isTurnOver = true
        self.isSpymaster = true
        self.clueCellPanel.isHidden = false
        self.clueCellPanel.txtQuantityClue.text = ""
        self.clueCellPanel.txtWordClue.text = ""
        self.gameLogPanel.gameLogLabel.text = ""
    }
    
    func displayMessageLabel(clue: Clue) -> String {
        return isSpymaster ? "Give your operatives a clue." : "\(clue.word) \(clue.quantity)"
    }
    
    func changeViewColor() {
        if isBlueTeam {
            self.headerPanel.messageLabel.backgroundColor = .blue
        } else {
            self.headerPanel.messageLabel.backgroundColor = .red
        }
    }
    
    func displayWinner() {
        if blueScore == 0 {
            
            Toast.ok(view: self, title:  "Blue wins!", message: "Blue team wins the game!", handler: nil)
        }
        if redScore == 0 {
            
            Toast.ok(view: self, title:  "Red wins!", message: "Red team wins the game!", handler: nil)
        }
    }
    
    // MARK: - CardCellDelegate
    func didTapWordButtonIn(_ card: Card) {
        print("DEBUG: card tapped")

        if(isSpymaster == false)
        {
            self.gameLogPanel.gameLogLabel.text! += " \n Player taps \(card.word)"
            self.accessibilityActivate()
        }
//        else
//        {
//            self.gameLogPanel.gameLogLabel.text! = "Game Log:"
//        }
   
    }
    
    // MARK: - GiveClueDelegate
    func spymasterDidGiveClue(_ clue: Clue) {
        
        isSpymaster = false
        self.collectionView.reloadData()
        
        isBlueTeam = !(isBlueTeam)
        changeViewColor()
        
        clueCellPanel.isHidden = true
        headerPanel.messageLabel.text = displayMessageLabel(clue: clue)
        self.gameLogPanel.gameLogLabel.text! += "\n Spymaster gives clue: \(clue.word) \(clue.quantity)"
        
        numberOfGuesses = clue.quantity
        
    }

}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = board!.cards[indexPath.row]
        
        if(isSpymaster == false && numberOfGuesses > 0)
        {
            numbers.append(indexPath.row)

            numberOfGuesses -= 1
            
            if card.color == .Black {
                //Team lose game
                Toast.ok(view: self, title:  "Game Over!", message: "You lose the game", handler: nil)
                card.color = .Black
                
                self.collectionView.reloadData()
                resetViewsWhenTurnOver()
                self.headerPanel.messageLabel.backgroundColor = UIColor(named: "DarkGreen")

            }
            if card.color == .Pale {
                //Oposite teams turn starts
                resetViewsWhenTurnOver()
                
                changeViewColor()
                
                self.collectionView.reloadData()
            }
            if card.color == .Blue {
                if isBlueTeam {
                    card.color = .Blue
                    if blueScore == 0 {
                        Toast.ok(view: self, title:  "Game Over!", message: "You win the game", handler: nil)
                    } else {
                        blueScore -= 1
                        self.headerPanel.lblBlueScore.text = "\(blueScore)"
                    }
                    
                } else {
                    card.color = .Blue
                    if blueScore == 0 {
                        Toast.ok(view: self, title:  "Game Over!", message: "You win the game", handler: nil)
                    } else {
                        blueScore -= 1
                        self.headerPanel.lblBlueScore.text = "\(blueScore)"
                    }
                    resetViewsWhenTurnOver()
                }
                self.collectionView.reloadData()
            }
            if card.color == .Red {
                if isBlueTeam {
                    card.color = .Red
                    if redScore == 0 {
                        Toast.ok(view: self, title:  "Game Over!", message: "You win the game", handler: nil)
                    } else {
                        redScore -= 1
                        self.headerPanel.lblRedScore.text = "\(redScore)"
                    }
                    resetViewsWhenTurnOver()
                    
                } else {
                    card.color = .Red
                    if redScore == 0 {
                        Toast.ok(view: self, title:  "Game Over!", message: "You win the game", handler: nil)
                    } else {
                        redScore -= 1
                        self.headerPanel.lblRedScore.text = "\(redScore)"
                    }
                }
                self.collectionView.reloadData()
            }
            self.gameLogPanel.gameLogLabel.text! += " \n Player taps \(card.word)"
            
        }
//        else
//        {
//            self.gameLogPanel.gameLogLabel.text! = "Game Log:"
//        }
        if numberOfGuesses == 0 {
            resetViewsWhenTurnOver()
        }
       

    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.board!.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        displayWinner()
        
//        Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(self.changeSpymasterDebug), userInfo: nil, repeats: true)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as! CardCell
        cell.card = self.board!.cards[indexPath.row]
        cell.delegate = self
        
        if !isSpymaster
        {
            if !(numbers.contains(indexPath.row)) {
                cell.backgroundColor = UIColor(named: "beige")
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (view.frame.width - 5) / 5
        let height = (view.frame.width) / 7
        return CGSize(width: width, height: height)
    }
}

