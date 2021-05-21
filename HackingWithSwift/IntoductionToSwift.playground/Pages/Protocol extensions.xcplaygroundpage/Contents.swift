//: [Previous](@previous)

import Foundation

//extension Int {
//    func clamp(low: Int, high: Int) -> Int {
//        if (self > high) {
//            // if we are higher than the upper bound, return the upper bound
//            return high
//        } else if (self < low) {
//            // if we are lower than the lower bound, return the lower bound
//            return low
//        }
//
//        // we are inside the range, so return our value
//        return self
//    }
//}

extension BinaryInteger {
    func clamp(low: Self, high: Self) -> Self {
        if (self > high) {
            return high
        } else if (self < low) {
            return low
        }

        return self
    }
}

let i: Int = 8
print(i.clamp(low: 0, high: 5))

protocol Employee {
    var name: String { get set }
    var jobTitle: String { get set }
    func doWork()
}

extension Employee {
    func doWork() {
        print("I'm busy!")
    }
}



//: [Next](@next)
