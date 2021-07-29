//
//  LinkedQueue.swift
//  LinkedQueue
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

final class LinkedQueueNode<Element> {
    var value: Element
    var next: LinkedQueueNode?

    init(value: Element, next: LinkedQueueNode? = nil) {
        self.value = value
        self.next = next
    }
}

final class LinkedQueue<Element>: ExpressibleByArrayLiteral, Sequence {
    var start: LinkedQueueNode<Element>?
    var count: Int

    func append(_ element: Element) {
        start = LinkedQueueNode(value: element, next: start)
    }

    func dequeue() -> Element? {
        defer { start = start?.next }
        return start?.value
    }

    init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            start = LinkedQueueNode(value: element, next: start)
        }

        count = elements.count
    }

    init(array: [Element]) {
        for element in array.reversed() {
            start = LinkedQueueNode(value: element, next: start)
        }
        count = array.count
    }

    func makeIterator() -> LinkedQueueIterator<Element> {
        LinkedQueueIterator(current: start)
    }
}

struct LinkedQueueIterator<Element>: IteratorProtocol {
    var current: LinkedQueueNode<Element>?

    mutating func next() -> LinkedQueueNode<Element>? {
        defer { current = current?.next }
        return current
    }
}
