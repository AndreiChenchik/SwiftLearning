//
//  AsynchronousTest.swift
//  AsynchronousTest
//
//  Created by Andrei Chenchik on 16/6/21.
//

import XCTest
@testable import First

class AsynchronousTest: XCTestCase {

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
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPrimesUpTo100ShouldBe0() {
        // given
        let maximumCount = 100

        // when
        PrimeCalculator.calculate(upTo: maximumCount) {
            // then
            XCTAssertEqual($0.count, 0)
        }
    }

}
