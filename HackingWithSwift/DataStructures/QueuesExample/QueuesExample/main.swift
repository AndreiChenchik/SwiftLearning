//
//  main.swift
//  QueuesExample
//
//  Created by Andrei Chenchik on 29/7/21.
//

import Foundation

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

for item in work {
    print(item.name)
}

print(work.dequeue())
print(work.dequeue())
print(work.dequeue())
print(work.dequeue())
print(work.dequeue())

