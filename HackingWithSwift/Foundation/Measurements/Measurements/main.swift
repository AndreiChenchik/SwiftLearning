//
//  main.swift
//  Measurements
//
//  Created by Andrei Chenchik on 2/8/21.
//

import Foundation

let distanceCentimeters = Measurement(value: 225, unit: UnitLength.centimeters)
let distanceInches = distanceCentimeters.converted(to: .inches)
print(distanceInches)

let weightPounds = Measurement(value: 140, unit: UnitMass.pounds)
let weightKilos = weightPounds.converted(to: .kilograms)
print(weightKilos)

let durationSeconds = Measurement(value: 3452, unit: UnitDuration.seconds)
let durationHours = durationSeconds.converted(to: .hours)
print(durationHours)

let gpa = Measurement(value: 150, unit: UnitPressure.gigapascals)
let mmhg = gpa.converted(to: .millimetersOfMercury)
print(mmhg)

let weightStones = weightPounds.converted(to: .stones)

let formatter = MeasurementFormatter()
formatter.locale = Locale(identifier: "fr_FR")
print(formatter.string(from: weightStones))

let distanceInches2 = Measurement(value: 3, unit: UnitLength.inches)
let distanceCentimiters2 = Measurement(value: 25, unit: UnitLength.centimeters)
let total = distanceInches2 + distanceCentimiters2
print(total)


let jugSize = Measurement(value: 1, unit: UnitVolume.liters)
let drinkAmount = Measurement(value: 1, unit: UnitVolume.pints)
let remainingSpaces = jugSize - drinkAmount
print(remainingSpaces)

let wheelCircumference = Measurement(value: 15, unit: UnitLength.centimeters)
let turnCount = 15.0
let movement = wheelCircumference * turnCount
print(movement)

let totalTime = Measurement(value: 3, unit: UnitDuration.hours)
let speakerCount = 15.0
let timePerSpeaker = totalTime / speakerCount
print(timePerSpeaker)

let length1 = Measurement(value: 1, unit: UnitArea.squareKilometers)
let length2 = Measurement(value: 1_000_000, unit: UnitArea.squareMeters)
print(length1 == length2)

let maxBottleSize = Measurement(value: 100, unit: UnitVolume.milliliters)
let waterBottle = Measurement(value: 0.5, unit: UnitVolume.liters)

if waterBottle < maxBottleSize {
    print("This can go on the flight")
} else {
    print("Sorry, please dispose of this bottle")
}

let lowestIdealWind = Measurement(value: 5, unit: UnitSpeed.kilometersPerHour)
let highestIdealWind = Measurement(value: 20, unit: UnitSpeed.kilometersPerHour)
let idealWindRange = lowestIdealWind...highestIdealWind

let currentWind = Measurement(value: 15, unit: UnitSpeed.kilometersPerHour)

if idealWindRange.contains(currentWind) {
    print("Let's go fly a kite!")
}
