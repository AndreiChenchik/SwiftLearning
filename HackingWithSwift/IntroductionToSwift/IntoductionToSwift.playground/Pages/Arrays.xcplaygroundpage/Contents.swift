//: [Previous](@previous)

import Foundation

var evenNumbers = [2, 4, 6, 8]
var songs: [String] = ["Shake it Off", "You Belong with Me", "Back to December"]

var songsWithNumbers: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 1]
songs[0]

type(of: songs)

var songs2: [String] = []
var songs3 = [String]()

songs2.append("Shake it Off")
songs3.append("Shake it Off")

var songs4 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]

var both = songs + songs4 


//: [Next](@next)
