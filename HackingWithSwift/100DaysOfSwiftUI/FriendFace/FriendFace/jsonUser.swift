////
////  User.swift
////  FriendFace
////
////  Created by Andrei Chenchik on 21/6/21.
////

import Foundation

struct jsonUser: Codable, Identifiable  {
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
    let friends: [jsonFriend]

    var formattedTags: String { tags.joined(separator: ", ") }
}
