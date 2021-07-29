//
//  main.swift
//  LinkedListsExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation





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





var third = LinkedListEnumNode.node(value: 3, next: nil)
var second = LinkedListEnumNode.node(value: 2, next: third)
var first = LinkedListEnumNode.node(value: 1, next: second)

let enumList = LinkedListEnum(start: first)
var currentNode = list.start





for item in enumList {
    switch item {
    case .node(value: let value, next: _):
        print(value)
    }
}
