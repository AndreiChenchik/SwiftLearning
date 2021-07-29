//
//  Work.swift
//  Work
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

protocol Prioritized {
    var priority: Int { get }
}

struct Work: Prioritized {
    let name: String
    let priority: Int
}


