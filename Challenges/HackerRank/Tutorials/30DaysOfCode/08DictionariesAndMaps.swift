import Foundation

// Enter your code here. Read input from STDIN. Print output to STDOUT
let n = Int(readLine()!)!

var phoneBook: [String: String] = [:]
var line: String
var lineComponents: [String]

var name: String
var phone: String

for _ in 1...n {
    line = readLine()!
    lineComponents = line.components(separatedBy: " ")

    name = lineComponents[0]
    phone = lineComponents[1]

    phoneBook[name] = phone
}

var query = readLine()
while query != nil {
    if let phone = phoneBook[query!] { 
        print(query! + "=" + phone) 
    } else {
        print("Not found")
    }

    query = readLine()
}
