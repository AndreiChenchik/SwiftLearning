//
//  main.swift
//  SortedArrayExample
//
//  Created by Andrei Chenchik on 31/7/21.
//

import Foundation

struct SortedArray<Element>: CustomStringConvertible, RandomAccessCollection {
    private var items = [Element]()
    var sortBefore: (Element, Element) -> Bool

    init(comparator: @escaping (Element, Element) -> Bool) {
        sortBefore = comparator
    }

    var count: Int { items.count }
    var description: String { items.description }
    var startIndex: Int { items.startIndex }
    var endIndex: Int { items.endIndex }

    subscript(position: Int) -> Element {
        items[position]
    }


    mutating func insert(_ element: Element) {
        for (i, item) in items.enumerated() {
            if sortBefore(element, item) {
                items.insert(element, at: i)
                return
            }
        }

        items.append(element)
    }

    mutating func remove(at index: Int) {
        items.remove(at: index)
    }

    @warn_unqualified_access func min() -> Element? {
        items.first
    }

    @warn_unqualified_access func max() -> Element? {
        items.last
    }

    func minAndMax() -> (min: Element?, max: Element?) {
        (self.min(), self.max())
    }
}

extension SortedArray where Element: Comparable {
    init() {
        self.init(comparator: <)
    }
}

var items = SortedArray<Int>()
items.insert(5)
items.insert(3)
items.insert(8)
print(items)

print(items.min())
print(items.max())
