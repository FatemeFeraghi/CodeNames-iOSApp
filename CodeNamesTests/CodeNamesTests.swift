//
//  CodeNamesTests.swift
//  CodeNamesTests
//
//  Created by Fateme Feraghi on 2022-04-18.
//

import XCTest
@testable import CodeNames

class CodeNamesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBoardModel() {
        
        let size = 5
        let board = Board(size: size)
        
        XCTAssertEqual(size, 5)
    }
    
    
    func testAPIRequest() {
        
        let urlString = "http://localhost:8080/words?quantity=25"
        
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // thenXCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
        
    }
    
    func testCorrectColors() {
        
        let size = 25
        let board = Board(size: size)
        
        board.assignKey(size: size)
        
        var hasWrongColor = false
        
        for card in board.cards {
            
            switch card.color {
            case .Red, .Blue, .Black, .Pale:
                break
            default :
                hasWrongColor = true
            }
        }

        XCTAssertFalse(hasWrongColor)
    }
    
    
    func testCardWords() {
        let size = 25
        let board = Board(size: size)
        
        board.assignKey(size: size)
        
        var isEmpty = false
        
        for card in board.cards {
            if card.word == ""  {
                isEmpty = true
            }
        }

        XCTAssertFalse(isEmpty)
    }
    
    
    func testWordSize() {
        
        let size = 25
        let board = Board(size: size)
        
        board.assignKey(size: size)
        
        var exceedSize = false
        
        for card in board.cards {
            if card.word.count > 8  {
                exceedSize = true
            }
        }

        XCTAssertFalse(exceedSize)
        
    }
    
    func testQuantityRedCards() {
        let size = 25
        let board = Board(size: size)
        
        board.assignKey(size: size)
        
        var counter : Int = 0
        let target : Int = 8
        
        for card in board.cards {
            if card.color == .Red {
                counter += 1
            }
        }
        XCTAssertEqual(counter, target)
    }
    
    func testQuantityBlueCards() {
        let size = 25
        let board = Board(size: size)
        
        board.assignKey(size: size)
        
        var counter : Int = 0
        let target : Int = 9
        
        for card in board.cards {
            if card.color == .Blue {
                counter += 1
            }
        }
        XCTAssertEqual(counter, target)
    }
    

    func testQuantityBlackCards() {
        let size = 25
        let board = Board(size: size)
        
        board.assignKey(size: size)
        
        var counter : Int = 0
        let target : Int = 1
        
        for card in board.cards {
            if card.color == .Black {
                counter += 1
            }
        }
        XCTAssertEqual(counter, target)
    }
    
    func testQuantityPaleCards() {
        let size = 25
        let board = Board(size: size)
        
        board.assignKey(size: size)
        
        var counter : Int = 0
        let target : Int = 7
        
        for card in board.cards {
            if card.color == .Pale {
                counter += 1
            }
        }
        XCTAssertEqual(counter, target)
    }
    
    
    func testClue() {
        
        let quantity = 2
        let word = "swim"
        let clue = Clue(quantity: quantity, word: word)
        
        XCTAssertEqual(clue.quantity, 2)
    }

}
