//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

enum Planet: Int {
    case mercury    // 0
    case vanus      // 1
    case earth      // 2
    case mars       // 3
}

enum Planet2: Int {
    case mercury = 1// 1
    case vanus      // 2
    case earth      // 3
    case mars       // 4
}

let earth = Planet(rawValue: 2)
let earth2 = Planet2(rawValue: 3)

//: [Next](@next)
