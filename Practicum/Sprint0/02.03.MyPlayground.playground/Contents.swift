import UIKit

var greeting = "Hello, world"

print(greeting)

var 😀 = "I'm ok"
print(😀)

func printSomething(_ data: String...) {
    for item in data {
        print(item)
    }
}

printSomething(greeting, greeting)

var price = 100

print(price + 50)
print(price - 1)
print(price / 3)
print(price * 7)

var price1 = 100
var price2 = 50

print(price1 == price2) // false
print(price1 != price2) // true

print(price1 > price2) // false
print(price1 < price2) // true

print(price1 >= price2) // false
print(price1 <= price2) // true

