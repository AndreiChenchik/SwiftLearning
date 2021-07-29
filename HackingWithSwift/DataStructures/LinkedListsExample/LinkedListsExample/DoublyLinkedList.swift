//
//  DoublyLinkedList.swift
//  DoublyLinkedList
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation


final class DoublyLinkedListNode<Element> {
    var value: Element
    var next: DoublyLinkedListNode?
    var prev: DoublyLinkedListNode?

    init(value: Element, prev: DoublyLinkedListNode? = nil, next: DoublyLinkedListNode? = nil) {
        self.value = value
        self.prev = prev
        self.next = next
    }
}

final class DoublyLinkedList<Element>: ExpressibleByArrayLiteral, Sequence {
    var start: DoublyLinkedListNode<Element>?
    var end: DoublyLinkedListNode<Element>?

    init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            start = DoublyLinkedListNode(value: element, prev: end, next: start)

            start?.next?.prev = start

            if end != nil {
                end = start
            }
        }
    }

    init(array: [Element]) {
        for element in array.reversed() {
            start = DoublyLinkedListNode(value: element, next: start)

            start?.next?.prev = start

            if end != nil {
                end = start
            }
        }
    }

    func makeIterator() -> DoublyLinkedListIterator<Element> {
        DoublyLinkedListIterator(current: start)
    }
}

struct DoublyLinkedListIterator<Element>: IteratorProtocol {
    var current: DoublyLinkedListNode<Element>?

    mutating func next() -> DoublyLinkedListNode<Element>? {
        defer { current = current?.next }
        return current
    }
}
