//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

func doubleInPlace(number: inout Int) {
    number *= 2
}

var myNum = 10
doubleInPlace(number: &myNum)

//: [Next](@next)
