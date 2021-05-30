//
//  Person.swift
//  Project10
//
//  Created by Andrei Chenchik on 30/5/21.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
