//
//  MainViewController.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-28.
//

import UIKit

private let cardCellIdentifier = "CardCell"

class MainViewController: UIViewController {
    
    private let headerPanel = HeaderPanel()


    lazy var board : Board = Board(size: 25)
    var isSpymaster = false

    
    
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
        print("\(board.cards[0].word) + \(board.cards[0].color)")
        print("\(board.cards[1].word) + \(board.cards[1].color)")
        print("\(board.cards[2].word) + \(board.cards[2].color)")
        configureUI()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.board.assignKey(size: 3)
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
    
        view.addSubviews(headerPanel, collectionView, gameLogPanel)
        
        headerPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerPanel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.headerPanel.topAnchor, constant: 150).isActive = true
        
        gameLogPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameLogPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameLogPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        gameLogPanel.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 10).isActive = true
        
    }

}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.board.size

    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(self.changeSpymasterDebug), userInfo: nil, repeats: true)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifier, for: indexPath) as! CardCell
        cell.card = self.board.cards[indexPath.row]
        
        if(self.isSpymaster == false)
        {
            cell.backgroundColor = .lightGray
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

