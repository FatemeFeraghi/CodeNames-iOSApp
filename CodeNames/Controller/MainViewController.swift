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

    var board : Board?
    var isSpymaster = true
    var isBlueTeam = false
    
    public var blueTeamPlayers : [Player] = []
    public var redTeamPlayers : [Player] = []
    
//    lazy var blueTeam = Team(players: blueTeamPlayers, hasSpymaster: true, color: .Blue)
//    lazy var redTeam = Team(players: redTeamPlayers, hasSpymaster: true, color: .Red)
    
    private var blueScore = 9
    private var redScore = 8

    let clue : Clue = Clue()
    
    var isTurnOver = false
    var numberOfGuesses: Int = 0

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
        

//        if isSpymaster == false {
//            clueCellPanel.isHidden = true
//        } else {
//            clueCellPanel.isHidden = false
//        }
      
//        print("DEBUG")
//        print(redTeamPlayers[0].name)
//        print(redTeamPlayers[1].name)
//        print(blueTeamPlayers[0].name)
//        print(blueTeamPlayers[1].name)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.board!.assignKey(size: 3)
    }
    
    //Function to alternate spymaster boolean value
    @objc func changeSpymasterDebug()
    {
        self.isSpymaster = !(self.isSpymaster)
        self.collectionView.reloadData()
    }
    
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
        collectionView.topAnchor.constraint(equalTo: self.headerPanel.topAnchor, constant: 120).isActive = true
        
        clueCellPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        clueCellPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        clueCellPanel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        clueCellPanel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 5).isActive = true
        
        gameLogPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameLogPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameLogPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        gameLogPanel.topAnchor.constraint(equalTo: self.clueCellPanel.bottomAnchor, constant: 35).isActive = true
        
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
    
    // MARK: - CardCellDelegate
    func didTapWordButtonIn(_ card: Card) {
        print("DEBUG: card tapped")

        self.gameLogPanel.gameLogLabel.text! += " \n Player taps \(card.word)"
        self.accessibilityActivate()
    }
    
    func changeViewColor() {
        if isBlueTeam {
            self.headerPanel.messageLabel.backgroundColor = .blue
        } else {
            self.headerPanel.messageLabel.backgroundColor = .red
        }
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



private var numbers = [Int]()

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = board!.cards[indexPath.row]
        
        numbers.append(indexPath.row)

        if numberOfGuesses > 0 {
            
            numberOfGuesses -= 1
            
            if card.color == .Black {
                //Team lose game
                Toast.ok(view: self, title:  "Game Over!", message: "You lose the game", handler: nil)
                card.color = .Black
                self.collectionView.reloadData()
            }
            if card.color == .Pale {
                //Oposite teams turn starts
                resetViewsWhenTurnOver()
                
                self.collectionView.reloadData()
            }
            if card.color == .Blue {
                if isBlueTeam {
                    card.color = .Blue
                    if blueScore == 0 {
                        Toast.ok(view: self, title:  "Game Over!", message: "You win the game", handler: nil)
                    } else {
                        blueScore -= 1
                    }
                    
                } else {
                    card.color = .Blue
                    if blueScore == 0 {
                        Toast.ok(view: self, title:  "Game Over!", message: "You win the game", handler: nil)
                    } else {
                        blueScore -= 1
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
                    }
                    resetViewsWhenTurnOver()
                    
                } else {
                    card.color = .Red
                    if redScore == 0 {
                        Toast.ok(view: self, title:  "Game Over!", message: "You win the game", handler: nil)
                    } else {
                        redScore -= 1
                    }
                }
                self.collectionView.reloadData()
            }
        }
        if numberOfGuesses == 0 {
            resetViewsWhenTurnOver()
        }
       
        
        self.gameLogPanel.gameLogLabel.text! += " \n Player taps \(card.word)"

    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.board!.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(self.changeSpymasterDebug), userInfo: nil, repeats: true)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as! CardCell
        cell.card = self.board!.cards[indexPath.row]
        cell.delegate = self
        
        if(self.isSpymaster == false)
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

