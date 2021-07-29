//
//  Queue.swift
//  Queue
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

struct Queue<Element> {
    private var array = [Element]()

    init(_ items: [Element]) {
        self.array = items
    }

    init() { }

    var first: Element? { array.first }
    var last: Element? { array.last }

    mutating func append(_ element: Element) {
        array.append(element)
    }

    mutating func dequeue() -> Element? {
        guard array.count > 0 else { return nil }
        return array.remove(at: 0)
    }

}

extension Queue: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}

extension Queue where Element: Prioritized {
    mutating func dequeue() -> Element? {
        guard array.count > 0 else { return nil }
        var choice = array[0]
        var choiceIndex = 0

        for (index, item) in array.enumerated() {
            if item.priority > choice.priority {
                choice = item
                choiceIndex = index
            }
        }

        return array.remove(at: choiceIndex)
    }
}

extension Queue: Sequence {
    func makeIterator() -> IndexingIterator<Array<Element>> {
        array.makeIterator()
    }
}
