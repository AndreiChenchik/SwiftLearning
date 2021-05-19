//: [Previous](@previous)

import Foundation

protocol Identifiable {
    var id: String { get set }
    func identify()
}

extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}

struct User: Identifiable {
    var id: String
    
    func identify() {
        print("Hey there!")
    }
}


let gumlooter = User(id: "gumlooter")
gumlooter.identify()

//: [Next](@next)
