//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by Andrei Chenchik on 22/6/21.
//

import Foundation

extension FileManager {
    func decode<T: Codable>(from file: String) -> T? {
        let url = getDocumentDirectory().appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load \(file) from bundle.")
            return nil
        }
        
        let decoder = JSONDecoder()
        
        do {
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            fatalError("Failed to decode \(file) from bundle. \(error.localizedDescription)")
        }
    }
    
    func encode<T: Codable>(_ data: T, to file: String) {
        do {
            let url = getDocumentDirectory().appendingPathComponent(file)
            let dataToSave = try JSONEncoder().encode(data)
            try dataToSave.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch {
            fatalError("Can't save data")
        }
        
    }
    
    func getDocumentDirectory() -> URL {
        let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
