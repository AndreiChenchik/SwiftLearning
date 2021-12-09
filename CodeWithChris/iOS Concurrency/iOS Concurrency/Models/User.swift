//
//  User.swift
//  iOS Concurrency
//
//  Created by Andrei Chenchik on 9/12/21.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
