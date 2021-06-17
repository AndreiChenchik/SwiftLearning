//
//  Habit.swift
//  Habitum
//
//  Created by Andrei Chenchik on 17/6/21.
//

import Foundation

struct Habit: Codable, Identifiable {
    let id: UUID
    let title: String
    let description: String
    var count: Int
    
    init(title: String, description: String, count: Int = 0) {
        self.title = title
        self.description = description
        self.count = count
        self.id = UUID()
    }
    
    mutating func decrementCount() {
        count -= 1
    }
    
    mutating func incrementCount() {
        count += 1
    }
}

class Habitum: ObservableObject {
    @Published var habits = [Habit]()
    
    init() {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "habits") {
            habits = decodeHabits(data)
        } else {
            habits.append(Habit(title: "Running", description: "Try do that more often"))
            habits.append(Habit(title: "Brush your teeth", description: "Every day"))
            habits.append(Habit(title: "Cleaning", description: "2 times a week is ok"))
        }
    }
    
    func save() {
        let defaults = UserDefaults.standard
        let data = encodeHabits()
        
        defaults.set(data, forKey: "habits")
    }
    
    func decodeHabits(_ data: Data) -> [Habit] {
        let decoder = JSONDecoder()
        guard let decodedHabits = try? decoder.decode([Habit].self, from: data) else { fatalError("Can't decode data for habits")}
        
        return decodedHabits
    }
    
    func encodeHabits() -> Data {
        let encoder = JSONEncoder()
        guard let encodedHabits = try? encoder.encode(habits) else { fatalError("Can't encode data of habits")}
        
        return encodedHabits
    }
}
