//
//  main.swift
//  BinaryTreesExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

let root = Node(1)
root.left = Node(5)
root.right = Node(3)

root.left?.left = Node(7)
root.left?.right = Node(2)

root.right?.left = Node(6)
root.right?.right = Node(4)

print(root.left?.right?.value ?? -1)
print("---")


for node in root {
    print(node.value)
}
print("---")


if let found = root.find(5) {
    print(found.value)
}

print("---")

let testRoot = Node(500_000)
for _ in 1...1_000_000 {
    testRoot.insert(Int.random(in: 2...1_000_000))
}

var start = CFAbsoluteTimeGetCurrent()
let result1 = testRoot.find(1)
var end = CFAbsoluteTimeGetCurrent()
print("Took \(String(format: "%f", end - start)) seconds to find \(result1?.value ?? -1)")

start = CFAbsoluteTimeGetCurrent()
let result2 = testRoot.fastFind(1)
end = CFAbsoluteTimeGetCurrent()
print("Took \(String(format: "%f", end - start)) seconds to fast find \(result2?.value ?? -1)")
