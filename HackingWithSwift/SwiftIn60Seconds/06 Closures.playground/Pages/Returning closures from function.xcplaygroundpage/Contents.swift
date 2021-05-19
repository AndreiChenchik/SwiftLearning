//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

func travel() -> (String) -> Void {
    return { location in
        print("I'm going to \(location)")
    }
}

let result = travel()
result("London")

let result2 = travel()("London")

//: [Next](@next)
