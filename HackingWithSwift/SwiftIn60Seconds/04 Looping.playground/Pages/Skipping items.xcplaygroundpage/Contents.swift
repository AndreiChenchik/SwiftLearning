//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    
    print(i)
}

var hoursStudied = 0
var goal = 10
repeat {
    hoursStudied += 1
    if hoursStudied > 4 {
        goal -= 1
        continue
    }
    print("I've studied for \(hoursStudied) hours")
} while hoursStudied < goal

//: [Next](@next)
