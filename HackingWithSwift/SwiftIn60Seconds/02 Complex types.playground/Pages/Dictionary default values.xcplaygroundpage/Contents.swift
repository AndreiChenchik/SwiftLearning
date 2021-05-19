//: [Previous](@previous)

import Foundation

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

let dictItem = favoriteIceCream["Paul"]
type(of: dictItem)

let dictItemWithDefault = favoriteIceCream["Paul", default: "Unknown"]
type(of: dictItemWithDefault)

//: [Next](@next)
