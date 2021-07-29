//
//  main.swift
//  BinaryTreesExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

class Node<Value>: Sequence {
    var value: Value
    var left: Node?
    var right: Node?
    var count = 1

    init(_ value: Value) {
        self.value = value
    }

    func makeIterator() -> NodeIterator<Value> {
        NodeIterator(items: Array(self))
    }
}

extension Node where Value: Comparable {
    func insert(_ newValue: Value) {
        if newValue < value {
            if left == nil {
                left = Node(newValue)
            } else {
                left?.insert(newValue)
            }
        } else if newValue > value {
            if right == nil {
                right = Node(newValue)
            }
        } else {
            count += 1
        }
    }

    func fastFind(_ search: Value) -> Node? {
        if value == search {
            return self
        }

        if search < value {
            return left?.fastFind(search)
        } else {
            return right?.fastFind(search)
        }
    }
}

extension Node where Value: Equatable {
    func find(_ search: Value) -> Node? {
        for node in self {
            if node.value == search {
                return node
            }
        }

        return nil
    }
}

struct NodeIterator<Value>: IteratorProtocol {
    var items: [Node<Value>]
    var position = 0

    mutating func next() -> Node<Value>? {
        if position < items.count {
            defer { position += 1 }
            return items[position]
        } else {
            return nil
        }
    }
}

extension Array {
    init<T>(_ node: Node<T>) where Element == Node<T> {
        self = [Node<T>]()

        if let left = node.left {
            self += Array(left)
        }

        self += [node]

        if let right = node.right {
            self += Array(right)
        }
    }
}


let root = Node(1)
root.left = Node(5)
root.right = Node(3)

root.left?.left = Node(7)
root.left?.right = Node(2)

root.right?.left = Node(6)
root.right?.right = Node(4)

print(root.left?.right?.value ?? -1)
print("---")


for node in root {
    print(node.value)
}
print("---")


if let found = root.find(5) {
    print(found.value)
}

print("---")

let testRoot = Node(500_000)
for _ in 1...100_000_000 {
    testRoot.insert(Int.random(in: 2...100_000_000))
}

var start = CFAbsoluteTimeGetCurrent()
let result1 = testRoot.find(1)
var end = CFAbsoluteTimeGetCurrent()
print("Took \(String(format: "%f", end - start)) seconds to find \(result1?.value ?? -1)")

start = CFAbsoluteTimeGetCurrent()
let result2 = testRoot.fastFind(1)
end = CFAbsoluteTimeGetCurrent()
print("Took \(String(format: "%f", end - start)) seconds to fast find \(result2?.value ?? -1)")
