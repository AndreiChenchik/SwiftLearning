//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")
type(of: talking)

switch talking {
case .talking(let topic):
    print(topic)
case .bored:
    print("bored")
case .singing:
    print("singing")
case .running:
    print("running")
}

//: [Next](@next)
