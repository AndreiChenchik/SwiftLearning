//
//  Node.swift
//  Node
//
//  Created by Andrei Chenchik on 31/7/21.
//

import Foundation

class Node<Value>: Sequence {
    var value: Value
    var left: Node?
    var right: Node?
    var parent: Node?
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
                left?.parent = self
            } else {
                left?.insert(newValue)
            }
        } else if newValue > value {
            if right == nil {
                right = Node(newValue)
                right?.parent = self
            } else {
                right?.insert(newValue)
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

    func delete(_ item: Value) {
        guard let node = fastFind(item) else { return }

        node.count -= 1

        if node.count < 1 {
            if parent?.right?.value == node.value {
                parent?.right = nil
            } else {
                parent?.left = nil
            }

            if let rightChild = node.right {
                for _ in 1...rightChild.count {
                    parent?.insert(rightChild.value)
                }

            }

            if let leftChild = node.left {
                for _ in 1...leftChild.count {
                    parent?.insert(leftChild.value)
                }
            }
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
