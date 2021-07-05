//
//  Prospect.swift
//  HotProspects
//
//  Created by Andrei Chenchik on 5/7/21.
//

import Foundation

class Prospect: Identifiable, Codable {
    let id: UUID
    let dateAdded: Date
    var name: String
    var emailAddress: String
    fileprivate(set) var isContacted: Bool
    
    init(id: UUID = UUID(), dateAdded: Date = Date(), name: String = "Anonymous", emailAddress: String = "", isContacted: Bool = false) {
        self.id = id
        self.dateAdded = dateAdded
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
    }
}

class Prospects: ObservableObject {
    static let saveKey = "SavedData"
    
    @Published private(set) var people: [Prospect]
    
    init() {
        if let decoded: [Prospect] = FileManager.default.decode(from: Self.saveKey) {
            self.people = decoded
            return
        }

        self.people = []
    }
    
    private func save() {
        FileManager.default.encode(people, to: Self.saveKey)
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
