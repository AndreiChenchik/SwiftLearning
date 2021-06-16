//
//  Hater.swift
//  First
//
//  Created by Andrei Chenchik on 16/6/21.
//

import Foundation

struct Hater {
    var hating = false
    
    mutating func hadABadDay() {
        hating = true
    }
    
    mutating func hadAGoodDay() {
        hating = false
    }
}
