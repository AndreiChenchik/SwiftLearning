//
//  LifecycleTests.swift
//  FirstTests
//
//  Created by Andrei Chenchik on 16/6/21.
//

import XCTest

class LifecycleTests: XCTestCase {
    override class func setUp() {
        print("In class setUp.")
    }
    
    override class func tearDown() {
        print("In class tearDown.")
    }
    
    override func setUpWithError() throws {
        print("In setUp.")
    }
    
    override func tearDownWithError() throws {
        print("In tearDown.")
    }
    
    func testExample() throws {
        print("Starting test.")
        
        addTeardownBlock {
            print("In first tearDown block.")
        }
        
        print("In middle of test.")
        
        addTeardownBlock {
            print("In second tearDown block.")
        }
        
        print("Finishing test.")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
