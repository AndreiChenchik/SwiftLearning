//
//  main.swift
//  OrderedSetExample
//
//  Created by Andrei Chenchik on 31/7/21.
//

import Foundation

struct OrderedSet<Element: Hashable>: Equatable {
    public private(set) var array = [Element]()
    private var set = Set<Element>()

    var count: Int { array.count }
    var isEmpty: Bool { array.isEmpty }

    init() { }

    init(_ array: [Element]) {
        for element in array {
            append(element)
        }
    }

    func contains(_ member: Element) -> Bool {
        set.contains(member)
    }

    @discardableResult
    mutating func append(_ newElement: Element) -> Bool {
        if set.insert(newElement).inserted {
            array.append(newElement)
            return true
        } else {
            return false
        }
    }

    static func ==(lhs: OrderedSet, rhs: OrderedSet) -> Bool {
        lhs.array == rhs.array
    }
}

extension OrderedSet: RandomAccessCollection {
    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }

    subscript(position: Int) -> Element {
        array[position]
    }
}

let set = OrderedSet([5, 10, 15, 20, 15, 10, 5])

for item in set {
    print(item)
}
