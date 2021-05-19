//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}



//: [Next](@next)
