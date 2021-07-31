//
//  main.swift
//  TreeExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation



var andrew = Node("Andrew")
var john = Node("John")
andrew.add(child: john)

var paul = Node("Paul")
var sophie = Node("Sophie")
let charlotte = Node("Charlotte")
paul.add(child: sophie)
paul.add(child: charlotte)

let taylor = Node("Taylor")
sophie.add(child: taylor)

var root = Node("Terry")
root.add(child: andrew)
root.add(child: paul)

print(root)
print(paul)
print(paul == andrew)
print(paul != andrew)
print(paul == paul)

print(root.count)
print(andrew.count)

if let paul = root.find("Paul") {
    print(paul.count)
}

let terry =
    Node("Terry") {
        Node("Paul") {
            Node("Sophie")
            Node("Lottie")
        }

        Node("Andrew") {
            Node("John")
        }
    }

print(terry.count)
