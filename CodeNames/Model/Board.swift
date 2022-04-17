//
//  Board.swift
//  CodeNames
//
//  Created by Fateme Feraghi on 2022-03-29.
//

import Foundation
import UIKit

class Board {
    var size: Int
    var cards: [Card]
    var key: [Int]
    
    //Variables with hard coded proportions of cards for a 25-card board size
    var reds = 8
    var blues = 9
    var assassin = 1
    var bystanders = 7
    
    
    public var arrayOfRandomWords : [String]?
    public var finalWords : [String]?
    
    //Hard coded list of cards
    var listOfCards: [(Card)] = [
            Card(color: .Black, word: "game"),
            Card(color: .Black, word: "swim"),
            Card(color: .Black, word: "cook"),
            Card(color: .Black, word: "fly"),
            Card(color: .Black, word: "dance"),
            Card(color: .Black, word: "read"),
            Card(color: .Black, word: "study"),
            Card(color: .Black, word: "sing"),
            Card(color: .Black, word: "fight"),
            Card(color: .Black, word: "cry"),
            Card(color: .Black, word: "eat"),
            Card(color: .Black, word: "drink"),
            Card(color: .Black, word: "scream"),
            Card(color: .Black, word: "speak"),
            Card(color: .Black, word: "walk"),
            Card(color: .Black, word: "run"),
            Card(color: .Black, word: "build"),
            Card(color: .Black, word: "imagine"),
            Card(color: .Black, word: "draw"),
            Card(color: .Black, word: "design"),
            Card(color: .Black, word: "calculate"),
            Card(color: .Black, word: "paint"),
            Card(color: .Black, word: "shoot"),
            Card(color: .Black, word: "sport"),
            Card(color: .Black, word: "shoes")
        ]
    
    init(size: Int) {
        self.size =  size
        self.key = [size]
        
        //Call API to set the list of Cards with the required amount here.
        self.cards = listOfCards
//        RandomWordApi.generateWords(amountOfWords: String(self.size), successHandler: randomWordSuccessHandler, failHandler: randomWordFailHandler)
        CustomRandomWordApi.generateWords(amountOfWords: String(self.size), successHandler: customRandomWordSuccessHandler, failHandler: customRandomWordFailHandler)


    }
    func setSize(size : Int)
    {
        self.size = size
    }
    func assignKey(size: Int) {
        
        //Counter variables
        var redsCounter = 0
        var bluesCounter = 0
        var assassinCounter = 0
        var bystandersCounter = 0
        
        for card in self.cards {
            var isCorrect : Bool = false
            repeat{
                isCorrect = false
                let listOfColors : [CardColor] = [.Red, .Blue, .Black, .Pale]
                let randomColor = listOfColors.shuffled()[0]
                switch randomColor
                {
                    case .Red:
                        if(redsCounter < reds)
                        {
                            card.color = randomColor
                            redsCounter += 1
                            isCorrect = true
                        }
                        break
                    case .Blue:
                        if(bluesCounter < blues)
                        {
                            card.color = randomColor
                            bluesCounter += 1
                            isCorrect = true
                        }
                        break
                    case .Black:
                        if(assassinCounter < assassin)
                        {
                            card.color = randomColor
                            assassinCounter += 1
                            isCorrect = true
                        }
                        break
                    case .Pale:
                        if(bystandersCounter < bystanders)
                        {
                            card.color = randomColor
                            bystandersCounter += 1
                            isCorrect = true
                        }
                        break
                    default:
                        break
                }
                
            }while(isCorrect == false)
        }
        
    }
    
    func setCards(key: [Int], cards: [Card]) {
        
    }
    
    func createBoard(size: Int) {

    }
    
    //MARK: - Random Word Api
    
    func randomWordSuccessHandler(_ httpStatusCode : Int, _ response : [String])
    {
        if httpStatusCode == 200
        {
            guard let current = response as? [String]
            else
            {
                return
            }
            print(current)
            
            //Now iterate and check if they are real words
            self.arrayOfRandomWords = current
            for word in self.arrayOfRandomWords! {
                //print("\(word) - \(type(of: word))")
                DictionaryApi.checkWordExistance(word: word, successHandler: checkExistanceSuccessHandler, failHandler: checkExistanceFailHandler)
                
            }
            
            let sizeOfArray = self.finalWords?.count == nil ? 0 : self.finalWords!.count
            let checkSize = self.size - sizeOfArray
            
            //After all the words in the arrayOfRandomWords were checked on the dictionary, we will check if we already have the amount of words we needed.
            if(checkSize > 0)
            {
                //The array does not have the required amount of cards, call the API again to generate more words
                RandomWordApi.generateWords(amountOfWords: String(self.size), successHandler: randomWordSuccessHandler, failHandler: randomWordFailHandler)
            }
            else
            {
                //This else will be executed when all the cards already were set with a word
                print(self.finalWords!)
                
                
                //Call function to randomically distribute the cards
                self.assignKey(size: size)
            }
        }
        
    }
    func randomWordFailHandler(_ httpStatusCode : Int, _ errorMessage: String)
    {
        print("Error")
    }
    
    //MARK: - Dictionary API
    func checkExistanceSuccessHandler(_ word : String, _ response : [Word])
    {
        let sizeOfArray = self.finalWords?.count == nil ? 0 : self.finalWords!.count
        
        //The word exists on the dictionary, before adding it to the final array of words we need to check if the array already have the required amount of words we needed.
        if(sizeOfArray < self.size)
        {
            if(word.count <= 8)
            {
                //The ternary operator was used to fix the problem of adding an element to a nil array at first
                self.finalWords?.count == nil ? self.finalWords = [word] : self.finalWords!.append(word)
                
                //Setting the word for each card
                self.listOfCards[sizeOfArray].word = word
                
                print("\nDictionary response -> \(response) - \(type(of: response[0]))")
            }
        }
        
    
    }
    func checkExistanceFailHandler( _ errorMessage: String)
    {
        print(errorMessage)
    }
    
    //MARK: - Custom Random Word API
    func customRandomWordSuccessHandler(_ httpStatusCode : Int, _ response : [String])
    {
        if httpStatusCode == 200
        {
            guard let current = response as? [String]
            else
            {
                return
            }
            print(current)
            
            //Now iterate and check if they are real words
            self.arrayOfRandomWords = current
            for word in self.arrayOfRandomWords! {
                
                let sizeOfArray = self.finalWords?.count == nil ? 0 : self.finalWords!.count
                if(sizeOfArray < self.size)
                {
                    if(word.count <= 8)
                    {
                        //The ternary operator was used to fix the problem of adding an element to a nil array at first
                        self.finalWords?.count == nil ? self.finalWords = [word] : self.finalWords!.append(word)

                        //Setting the word for each card
                        self.listOfCards[sizeOfArray].word = word

                        print("\nDictionary response -> \(response) - \(type(of: response[0]))")
                    }
                }

                
            }
            
            let sizeOfArray = self.finalWords?.count == nil ? 0 : self.finalWords!.count
            let checkSize = self.size - sizeOfArray

            //After all the words in the arrayOfRandomWords were checked on the dictionary, we will check if we already have the amount of words we needed.
            if(checkSize > 0)
            {
                //The array does not have the required amount of cards, call the API again to generate more words
                CustomRandomWordApi.generateWords(amountOfWords: String(self.size), successHandler: customRandomWordSuccessHandler, failHandler: customRandomWordFailHandler)
            }
            else
            {
                //This else will be executed when all the cards already were set with a word
                print(self.finalWords!)


                //Call function to randomically distribute the cards
                self.assignKey(size: size)
            }
        }
        
    }
    func customRandomWordFailHandler(_ httpStatusCode : Int, _ errorMessage: String)
    {
        print("Error")
    }
}
