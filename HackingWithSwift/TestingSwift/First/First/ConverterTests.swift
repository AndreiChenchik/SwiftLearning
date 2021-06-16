//
//  ConverterTests.swift
//  FirstTests
//
//  Created by Andrei Chenchik on 16/6/21.
//

import XCTest
@testable import First

class ConverterTests: XCTestCase {
    var sut: Converter!

    override func setUpWithError() throws {
        sut = Converter()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
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
    
    func test_Converter_32FahrenheitConvertToCelsius_IsZero() {
        // given
        let input = 32.0
        
        // when
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // then
        XCTAssertEqual(celsius, 0, accuracy: 0.000001)
    }
    
    func test_Converter_212FahrenheitConvertToCelsius_Is100() {
        // given
        let input = 212.0
        
        // when
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // then
        XCTAssertEqual(celsius, 100, accuracy: 0.000001)
    }
    
    func test_Converter_100FahrenheitConvertToCelsius_Is37() {
        // given
        let input = 100.0
        
        
        // when
        let celsius = sut.convertToCelsius(fahrenheit: input)
        
        // then
        XCTAssertEqual(celsius, 37.777777, accuracy: 0.000001)
    }

}
