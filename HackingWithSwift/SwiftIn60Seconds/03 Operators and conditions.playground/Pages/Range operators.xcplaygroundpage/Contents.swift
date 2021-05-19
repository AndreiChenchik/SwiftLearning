//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let score = 85

switch score {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}

for i in 1...10 {
    print(i)
}

//: [Next](@next)
