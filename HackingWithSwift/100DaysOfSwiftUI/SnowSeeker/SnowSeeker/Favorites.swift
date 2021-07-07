//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Andrei Chenchik on 7/7/21.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        let defaults = UserDefaults.standard
        
        if let resortsArray = defaults.stringArray(forKey: saveKey) {
            self.resorts = Set(resortsArray)
            return
        }
        
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        
        save()
    }
    
    func save() {
        let defaults = UserDefaults.standard
        let resortsArray = Array(resorts)
        defaults.set(resortsArray, forKey: saveKey)
    }
}
