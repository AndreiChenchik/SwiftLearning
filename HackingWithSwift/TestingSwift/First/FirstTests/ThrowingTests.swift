//
//  ThrowingTests.swift
//  FirstTests
//
//  Created by Andrei Chenchik on 16/6/21.
//

import XCTest
@testable import First


class ThrowingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPlayingBioBlitzThrows() {
        let game = Game(name: "BioBlitz")

        do {
            try game.play()
            XCTFail()
        } catch GameError.notPurchased {
            // success!
        } catch {
            XCTFail()
        }
    }

    func testPlayingBlastazapThrows() {
        let game = Game(name: "Blastazap")

        XCTAssertThrowsError(try game.play()) { error in
            XCTAssertEqual(error as? GameError, GameError.notInstalled)
        }
    }
    
    
    func testPlayingExplodingMonkeysDoesntThrow() {
        let game = Game(name: "Exploding Monkeys")
        XCTAssertNoThrow(try game.play())
    }

    func testCrashyPlaneDoesntThrow() throws {
        let game = Game(name: "CrashyPlane")
        try game.play()
    }
}
