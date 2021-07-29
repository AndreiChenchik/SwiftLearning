//
//  LinkedListEnum.swift
//  LinkedListEnum
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation


struct LinkedListEnum<Element>: Sequence {
    var start: LinkedListEnumNode<Element>?

    func makeIterator() -> LinkedListEnumIterator<Element> {
        LinkedListEnumIterator(current: start)
    }
}

indirect enum LinkedListEnumNode<Element> {
    case node(value: Element, next: LinkedListEnumNode<Element>?)
}

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
