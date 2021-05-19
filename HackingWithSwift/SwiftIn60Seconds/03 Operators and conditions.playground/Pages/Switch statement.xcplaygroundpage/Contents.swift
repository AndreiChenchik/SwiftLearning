//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day")
}
//: [Next](@next)
