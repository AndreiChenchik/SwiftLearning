//
//  main.swift
//  LinkedListsExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation



final class LinkedListNode<Element> {
    var value: Element
    var next: LinkedListNode?

    init(value: Element, next: LinkedListNode? = nil) {
        self.value = value
        self.next = next
    }
}

final class LinkedList<Element>: ExpressibleByArrayLiteral, Sequence {
    var start: LinkedListNode<Element>?

    init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            start = LinkedListNode(value: element, next: start)
        }
    }

    init(array: [Element]) {
        for element in array.reversed() {
            start = LinkedListNode(value: element, next: start)
        }
    }

    func makeIterator() -> LinkedListIterator<Element> {
        LinkedListIterator(current: start)
    }
}

struct LinkedListIterator<Element>: IteratorProtocol {
    var current: LinkedListNode<Element>?

    mutating func next() -> LinkedListNode<Element>? {
        defer { current = current?.next }
        return current
    }
}

//let list = LinkedList(array: [1, 3, 5])
//
//var currentNode = list.start
//
//for node in list {
//    print(node.value)
//}

let array = Array(1...200_000)

var start = CFAbsoluteTimeGetCurrent()
var items = array

while items.isEmpty == false {
    items.remove(at: 0)
}

var end = CFAbsoluteTimeGetCurrent()
print("Took \(end - start) seconds to get to 0")

start = CFAbsoluteTimeGetCurrent()
items = array

while items.isEmpty == false {
    items.removeLast()
}

end = CFAbsoluteTimeGetCurrent()
print("Took \(end - start) seconds to get to 0")

let list = LinkedList(array: array)
start = CFAbsoluteTimeGetCurrent()

while let start = list.start {
    list.start = start.next
}

end = CFAbsoluteTimeGetCurrent()
print("Took \(end - start) seconds to get to 0")



struct LinkedListEnum<Element>: Sequence {
    var start: LinkedListEnumNode<Element>?

    func makeIterator() -> LinkedListEnumIterator<Element> {
        LinkedListEnumIterator(current: start)
    }
}

indirect enum LinkedListEnumNode<Element> {
    case node(value: Element, next: LinkedListEnumNode<Element>?)
}

var third = LinkedListEnumNode.node(value: 3, next: nil)
var second = LinkedListEnumNode.node(value: 2, next: third)
var first = LinkedListEnumNode.node(value: 1, next: second)

let enumList = LinkedListEnum(start: first)
var currentNode = list.start



struct LinkedListEnumIterator<Element>: IteratorProtocol {
    var current: LinkedListEnumNode<Element>?

    mutating func next() -> LinkedListEnumNode<Element>? {
        defer {
            switch current {
            case .node(value: _, next: let next):
                current = next
            case .none:
                break
            }
        }

        return current
    }
}

for item in enumList {
    switch item {
    case .node(value: let value, next: _):
        print(value)
    }
}
