//: [Previous](@previous)

import Foundation

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}


var test = [1, 2, 3, 4, 5]
test.remove(item: 3)
print(test)
//: [Next](@next)
