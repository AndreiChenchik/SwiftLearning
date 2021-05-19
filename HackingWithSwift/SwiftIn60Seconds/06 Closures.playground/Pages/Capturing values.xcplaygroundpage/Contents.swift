//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

func travel() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let result = travel()
result("London")
result("London")
result("London")

//: [Next](@next)
