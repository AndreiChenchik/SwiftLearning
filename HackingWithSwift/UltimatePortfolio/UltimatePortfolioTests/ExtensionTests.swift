//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by Andrei Chenchik on 16/7/21.
//

import XCTest
import SwiftUI
@testable import UltimatePortfolio

class ExtensionTests: XCTestCase {

    func testSequenceKeyPathSortingSelf() {
        let items = [1, 4, 3, 2, 5]
        let sortedItems = items.sorted(by: \.self)
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "The sorted numbers must be ascending")
    }

    func testSequenceKeyPathSortingCustom() {
        // Given
        struct SimpleStruct: Equatable {
            let value: String
        }

        let item1 = SimpleStruct(value: "A")
        let item2 = SimpleStruct(value: "B")
        let item3 = SimpleStruct(value: "B")
        let item4 = SimpleStruct(value: "C")
        let item5 = SimpleStruct(value: "D")
        let items = [item1, item2, item3, item4, item5]

        // When
        let sortedItems = items.sorted(by: \.value) { $0 > $1 }

        // Then
        XCTAssertEqual(
            sortedItems,
            [item5, item4, item3, item2, item1],
            "The reverse sorted items must be in reverse order"
        )
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty,
                       "Awards.json should decode to a non-empty array.")
    }

    func testBundleDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(data, "The rain in Spain falls mainly on the Spaniards.",
                       "The string must match the content of DecodableString.json.")
    }

    func testBundleDecodingDict() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode([String: Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(data.count, 3, "There should be 3 items decoded from DecodableDictionary.json.")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain Int to String mappings.")
    }

    func testBindingOnChange() {
        // Given
        var onChangeFunctionRun = false

        func exampleFunctionToCall() {
            onChangeFunctionRun = true
        }

        var storedValue = ""
        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )

        let changedBinding = binding.onChange(exampleFunctionToCall)

        // When
        changedBinding.wrappedValue = "Test"

        // Then
        XCTAssertTrue(onChangeFunctionRun, "The onChange() function must be run when the binding is changed.")
    }
}
