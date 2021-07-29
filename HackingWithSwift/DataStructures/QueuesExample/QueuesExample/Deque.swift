//
//  Deque.swift
//  Deque
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

struct Deque<Element> {
    private var array = [Element]()

    init(_ items: [Element]) {
        self.array = items
    }

    init() { }

    var first: Element? { array.first }
    var last: Element? { array.last }

    mutating func prepend(_ element: Element) {
        array.insert(element, at: 0)
    }

    mutating func append(_ element: Element) {
        array.append(element)
    }

    mutating func dequeueFront() -> Element? {
        guard array.count > 0 else { return nil }
        return array.remove(at: 0)
    }

    mutating func dequeueBack() -> Element? {
        guard array.count > 0 else { return nil }
        return array.removeLast()
    }
}

extension Deque: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self.array = elements
    }
}

extension Deque where Element: Equatable {
    @inlinable
    func firstIndex(of element: Element) -> Int? {
        array.firstIndex(of: element)
    }

    @inlinable
    func contains(_ element: Element) -> Bool {
        array.contains(element)
    }
}

extension Deque: Sequence {
    func makeIterator() -> IndexingIterator<Array<Element>> {
        array.makeIterator()
    }
}
