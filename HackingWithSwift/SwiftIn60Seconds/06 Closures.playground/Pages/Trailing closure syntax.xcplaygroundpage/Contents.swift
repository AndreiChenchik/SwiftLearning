//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel {
    print("I'm driving in my car")
}

//: [Next](@next)
