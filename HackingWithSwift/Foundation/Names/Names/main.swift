//
//  main.swift
//  Names
//
//  Created by Andrei Chenchik on 3/8/21.
//

import Foundation

var components = PersonNameComponents()
components.givenName = "Taylor"
components.middleName = "Alison"
components.familyName = "Swift"
components.nickname = "Taytay"

let formatter = PersonNameComponentsFormatter()
formatter.style = .long
let defaultName = formatter.string(from: components)
print(defaultName)

if let paul = formatter.personNameComponents(from: "Paul Hudson") {
    print(paul)
}


