//
//  FirstTests.swift
//  FirstTests
//
//  Created by Andrei Chenchik on 16/6/21.
//

import XCTest
@testable import First

class FirstTests: XCTestCase {

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
    
    func testHatersStartsNicely() {
        // Given
        let hater = Hater()
        
        // Then
        XCTAssertFalse(hater.hating, "New Haters should not be hating")
    }
    
    func test_Hater_afterHavingABadDay_shouldBeHating() {
        // Given
        var hater = Hater()
        
        // When
        hater.hadABadDay()
        
        // Then
        XCTAssertTrue(hater.hating)
    }
    
    func test_Hater_afterHavingAGoodDay_shouldNotBeHating() {
        // Given
        var hater = Hater()
        
        // When
        hater.hadAGoodDay()
        
        // Then
        XCTAssertFalse(hater.hating)
    }
}
