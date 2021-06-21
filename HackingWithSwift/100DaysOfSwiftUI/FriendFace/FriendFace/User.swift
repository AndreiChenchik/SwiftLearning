//
//  User.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//

import Foundation

struct User: Codable, Identifiable  {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    var formattedRegisteredDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxx"
        if let date = formatter.date(from: registered) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        } else {
            return registered
        }
    }
    
    var formattedTags: String { tags.joined(separator: ", ") }
}
