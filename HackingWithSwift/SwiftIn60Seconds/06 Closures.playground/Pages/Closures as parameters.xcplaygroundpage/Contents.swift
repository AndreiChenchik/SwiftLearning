//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let driving = {
    print("I'm driving in may car")
}

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}


travel(action: driving)

//: [Next](@next)
