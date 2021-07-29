//
//  main.swift
//  TreeExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

final class Node<Value> {
    var value: Value
    private(set) var children: [Node]

    var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }

    init(_ value: Value) {
        self.value = value
        children = []
    }

    init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }

    func add(child: Node) {
        children.append(child)
    }
}

extension Node: Equatable where Value: Equatable {
    static func ==(lhs: Node, rhs: Node) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
}

extension Node: Hashable where Value: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}

extension Node: Decodable where Value: Decodable { }
extension Node: Encodable where Value: Encodable { }

extension Node where Value: Equatable {
    func find(_ value: Value) -> Node? {
        if self.value == value {
            return self
        }

        for child in children {
            if let match = child.find(value) {
                return match
            }
        }

        return nil
    }
}

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
