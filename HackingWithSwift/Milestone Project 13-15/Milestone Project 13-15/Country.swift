//
//  Country.swift
//  Milestone Project 13-15
//
//  Created by Andrei Chenchik on 1/6/21.
//

import Foundation

struct WikiQuery: Codable {
    var results: WikiQueryResults
}

struct WikiQueryResults: Codable {
    var bindings: [Country]
}

struct Country: Codable {
    var name: String? { countryLabel?.value }
    var populationNumber: Int? { Int(population?.value ?? "") }
    var lifeExpectancy: Double? { Double(life_expectancy?.value ?? "") }
    var fertilityRate: Double? { Double(total_fertility_rate?.value ?? "") }
    
    var countryLabel: WikiItem?
    var population: WikiItem?
    var total_fertility_rate: WikiItem?
    var life_expectancy: WikiItem?
}

struct WikiItem: Codable {
    var value: String
}
