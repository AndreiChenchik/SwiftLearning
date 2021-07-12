//
//  History.swift
//  Scrumdinger
//
//  Created by Andrei Chenchik on 12/7/21.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [String]
    var lengthInMinutes: Int
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attedees: [String], lengthInMinutes: Int, transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attedees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
