import Foundation

let numStrings = Int(readLine()!)!

func printEvenAndOdd(string: String) {
    // This prints inputString to stderr for debugging:
    fputs("string: " + string + "\n", stderr)
    

    // Print the even-indexed characters
    // Write your code here
    var index = 0
    let evenIndexed = string.filter { _ in
        defer { index += 1 }
        return index % 2 == 0
    }
    print(evenIndexed, terminator: "")
    
    // Print a space
    print(" ", terminator: "")
    
    // Print the odd-indexed characters
    // Write your code here
    index = 0
    let oddIndexed = string.filter { _ in
        defer { index += 1 }
        return index % 2 == 1
    }
    print(oddIndexed, terminator: "")


    // Print a newline
    print()
}

for _ in 1...numStrings {
    let inputString = readLine()!
    printEvenAndOdd(string: inputString)
}
