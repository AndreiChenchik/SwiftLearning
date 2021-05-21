//: [Previous](@previous)

import Foundation

var myInt = 0

extension Int {
    func plusOne() -> Int {
        return self + 1
    }
    
//    mutating func plusOne() {
//        self += 1
//    }
}

myInt.plusOne()


5.plusOne()


var myInt2 = 10
myInt.plusOne()
myInt

var str = """
    test


"""
str = str.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    mutating func trim() {
        self = trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
var str2 = """
    test


"""

str2.trim()
//: [Next](@next)
