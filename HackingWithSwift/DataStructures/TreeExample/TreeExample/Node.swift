//
//  Node.swift
//  Node
//
//  Created by Andrei Chenchik on 31/7/21.
//

import Foundation

final class Node<Value> {
    var value: Value
    private(set) var children: [Node]
    weak var parent: Node?

    var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }

    init(_ value: Value, parent: Node? = nil) {
        self.value = value
        children = []
    }

    init(_ value: Value, children: [Node], parent: Node? = nil) {
        self.value = value
        self.children = children

        for child in self.children {
            child.parent = self
        }
    }

    init(_ value: Value, parent: Node? = nil, @NodeBuilder builder: () -> [Node]) {
        self.value = value
        self.children = builder()

        for child in self.children {
            child.parent = self
        }
    }

    func add(child: Node) {
        child.parent = self
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

extension Node: Comparable where Value: Comparable {
    static func < (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        lhs.value < rhs.value
    }
}

@resultBuilder
struct NodeBuilder {
    static func buildBlock<Value>(_ children: Node<Value>...) -> [Node<Value>] {
        children
    }
}
