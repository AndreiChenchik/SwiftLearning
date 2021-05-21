//: [Previous](@previous)

import Foundation

protocol Employee {
    var name: String { get set }
    var jobTitle: String { get set }
    func doWork()
}

struct Executive: Employee {
    var name = "Steve Jobs"
    var jobTitle = "CEO"

    func doWork() {
        print("I'm strategizing!")
    }
}

struct Manager: Employee {
    var name = "Maurice Moss"
    var jobTitle = "Head of IT"

    func doWork() {
        print("I'm turning it off and on again.")
    }
}

let staff: [Employee] = [Executive(), Manager()]

for person in staff {
    person.doWork()
}

//: [Next](@next)
