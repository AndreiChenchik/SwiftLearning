//: [Previous](@previous)

import Foundation

class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}

let poppy = Poodle()
poppy.makeNoise()

//: [Next](@next)
