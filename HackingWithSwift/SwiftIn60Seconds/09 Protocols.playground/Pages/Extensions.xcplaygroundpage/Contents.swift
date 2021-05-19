//: [Previous](@previous)

import Foundation

extension Int {
    func squared() -> Int {
        return self * self
    }
    
}

let number = 8
number.squared()

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}

number.isEven

//: [Next](@next)
