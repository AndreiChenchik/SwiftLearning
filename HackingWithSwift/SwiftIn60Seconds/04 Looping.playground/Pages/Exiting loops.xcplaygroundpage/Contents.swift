//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

var countDown = 10

while countDown >= 0 {
    print(countDown)
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    countDown -= 1
}

print("Blast off!")

//: [Next](@next)
