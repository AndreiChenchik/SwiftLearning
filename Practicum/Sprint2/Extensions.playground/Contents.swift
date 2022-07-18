import UIKit

var greeting = "Hello, playground"

extension String {
    var whitespace: Int {
        var counter = 0
        for char in self {
            if char == " " {
                counter += 1
            }
        }
        return counter
    }
}

let hello = "Hello world"
print(hello.whitespace)

extension String {
    var onlyFirstCapitalized: String {
        var result = ""
        var first = true
        
        for char in self {
            if first {
                result.append(char.uppercased())
                first = false
            } else {
                result.append(char.lowercased())
            }
        }
        
        return result
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.onlyFirstCapitalized
    }
}

var hello2 = "hello, World"
hello2.capitalizeFirstLetter()
print(hello2)
