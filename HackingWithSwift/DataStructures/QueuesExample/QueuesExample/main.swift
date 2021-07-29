//
//  main.swift
//  QueuesExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

struct Queue<Element> {
    private var array = [Element]()

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

protocol Prioritized {
    var priority: Int { get }
}

struct Work: Prioritized {
    let name: String
    let priority: Int
}

let l = Work(name: "Low", priority: 1)
let ml = Work(name: "Medium Low", priority: 2)
let m = Work(name: "Medium", priority: 3)
let mh = Work(name: "Medium High", priority: 4)
let h = Work(name: "High", priority: 5)

var work = Queue<Work>()
work.append(l)
work.append(h)
work.append(ml)
work.append(mh)
work.append(m)

print(work.dequeue())
print(work.dequeue())
print(work.dequeue())
print(work.dequeue())
print(work.dequeue())

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

struct Deque<Element> {
    private var array = [Element]()

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

