//
//  LinkedList.swift
//  LinkedList
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
    var count: Int

    init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            start = LinkedListNode(value: element, next: start)
        }

        count = elements.count
    }

    init(array: [Element]) {
        for element in array.reversed() {
            start = LinkedListNode(value: element, next: start)
        }
        count = array.count
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
