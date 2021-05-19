//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}

travel { place in
    print("I'm going to \(place) in my car")
}


//: [Next](@next)
