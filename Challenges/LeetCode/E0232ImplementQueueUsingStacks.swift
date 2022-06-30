
class MyQueue {
    var stackIn: [Int]
    var stackOut: [Int]

    init() {
        self.stackIn = [Int]()
        self.stackOut = [Int]()
    }
    
    func push(_ x: Int) {
        self.stackIn.append(x)
    }
    
    func pop() -> Int {
        if stackOut.isEmpty {
            for _ in 1...stackIn.count {
                stackOut.append(stackIn.removeLast())
            }
        }
        
        return stackOut.removeLast()
    }
    
    func peek() -> Int {
        if stackOut.isEmpty {
            for _ in 1...stackIn.count {
                stackOut.append(stackIn.removeLast())
            }
        }
        
        return stackOut.last!   
    }
    
    func empty() -> Bool {
        return stackIn.isEmpty && stackOut.isEmpty
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * let obj = MyQueue()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */
 