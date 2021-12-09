//
//  main.swift
//  SwiftAlgorithms
//
//  Created by Andrei Chenchik on 9/12/21.
//

import Algorithms
import Foundation


// Chaining
let names1 = ["Jane", "Elizabeth", "Mary", "Kitty"]
let names2 = ["Daphne", "Eloise", "Francesca", "Hyacinth"]

for name in chain(names1, names2) {
    print(name)
}

let tooLow = 0...20
let tooHigh = 80...1000
let outOfBounds = chain(tooLow, tooHigh)

let value = 35
print(outOfBounds.contains(value))


let reservedSeats = 0...50
let unavailableSeats = [61, 68, 75, 75, 77, 92]
let disallowed = chain(reservedSeats, unavailableSeats)

let requestedSeat = 39
print(disallowed.contains(requestedSeat))

// Chunking
struct Student {
    let name: String
    let grade: String
}

let results = [
    Student(name: "Taylor", grade: "A"),
    Student(name: "Sophie", grade: "A"),
    Student(name: "Bella", grade: "B"),
    Student(name: "Rajesh", grade: "C"),
    Student(name: "Tony", grade: "C"),
    Student(name: "Theresa", grade: "D"),
    Student(name: "Boris", grade: "F")
]


let studentsByGrade = results.chunked(on: \.grade)
let studentsByName = results.sorted { $0.name < $1.name }.chunked(on: \.name.first!)

for (grade, students) in studentsByGrade {
    print("Grade: \(grade)")

    for student in students {
        print("\t\(student.name)")
    }

    print()
}

for (firstLetter, students) in studentsByName {
    print(firstLetter)

    for student in students {
        print("\t\(student.name)")
    }

    print()
}

let pairs = results.chunks(ofCount: 2)

for pair in pairs {
    let names = ListFormatter.localizedString(byJoining: pair.map(\.name))
    print(names)
}

// Random

let lotteryBalls = 1...50
let winningNumbers = lotteryBalls.randomSample(count: 7)
print(winningNumbers)

let people = ["Chidi", "Eleanor", "Jason", "Tahani"]
let selected = people.randomStableSample(count: 2)
print(selected)

// Striding

let numbers = 1...100
let oddNumbers = numbers.striding(by: 2)
// let oddNumbers = stride(from: numbers.lowerBound, through: numbers.upperBound, by: 2)

for oddNumber in oddNumbers {
    print(oddNumber)
}

let inputString = "a1b2c3d4e5"
let letters = inputString.striding(by: 2)

for letter in letters {
    print(letter)
}

// Unique

let allNumbers = [3, 7, 8, 8, 7, 57, 8, 7, 13, 8, 3, 7, 31]
let uniqueNumbers = allNumbers.uniqued().sorted()

for number in uniqueNumbers {
    print("\(number) in a lucky number")
}

struct City {
    let name: String
    let country: String
}

let destinations = [
    City(name: "Hamburg", country: "Germany"),
    City(name: "Kyoto", country: "Japan"),
    City(name: "Osaka", country: "Japan"),
    City(name: "Naples", country: "Italy"),
    City(name: "Florence", country: "Italy")
]

let selectedCities = destinations.uniqued(on: \.country)

for city in selectedCities {
    print("Visit \(city.name) in \(city.country)")
}

// Optionality

let numbers2 = [10, nil, 20, nil, 30]
let safeNumbers = numbers2.compactMap { $0 }
let safeNumber2 = numbers2.compacted()

print(safeNumber2.count)

// Loops

let people2 = ["Sophie", "Charlotte", "Maddie", "Sennen"]
let games = ["Mario Kart", "Boomerang Fu"]

let allOptions = product(people2, games)

for option in allOptions {
    print("\(option.0) will play \(option.1)")
}

let range = 1...12
let questionCount = 20
let allMultiples = product(range, range).randomSample(count: questionCount)

for pair in allMultiples {
    print("\(pair.0) x \(pair.1) is \(pair.0 * pair.1)")
}

let suspects = ["Colonel Mustard", "Professor Plum", "Mrs White"]
let locations = ["kitchen", "library", "study", "hall"]
let weapons = ["candlestick", "dagger", "lead pipe", "rope"]

let guesses = product(product(suspects, locations), weapons)

for guess in guesses {
    print("Was it \(guess.0.0) in the \(guess.0.1)  with the \(guess.1)?")
}

// Windows

let numbers3 = (1...100).adjacentPairs()

for pair in numbers3 {
    print("Pair \(pair.0) and \(pair.1)")
}

let numbers4 = (1...100).windows(ofCount: 5)

for group in numbers4 {
    let strings = group.map(String.init)
    print(ListFormatter.localizedString(byJoining: strings))
}

// Min and Max
let names = ["John", "Paul", "George", "Ringo"]

if let (first, last) = names.minAndMax() {
    print(first)
    print(last)
}

let scores = [42, 4, 23, 8, 16, 15]
let threeLowest = scores.min(count: 3)

print(threeLowest)
