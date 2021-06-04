//: [Previous](@previous)

import Foundation

extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self {
            closure()
        }
    }
}

let number = -5
number.times { print("Hello!") }

//: [Next](@next)
