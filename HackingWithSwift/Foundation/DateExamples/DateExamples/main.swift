//
//  main.swift
//  DateExamples
//
//  Created by Andrei Chenchik on 31/7/21.
//

import Foundation

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ru_RU")
formatter.dateStyle = .long
formatter.timeStyle = .full
print(formatter.string(from: Date()))


let isoFormatter = ISO8601DateFormatter()
print(isoFormatter.string(from: Date()))

let locFormatter = DateFormatter()
locFormatter.locale = Locale(identifier: "en_US")
locFormatter.setLocalizedDateFormatFromTemplate("Mydhm")
print(locFormatter.string(from: Date()))
