class Solution {
    var cache = [0: 0, 1: 1]
    
    func fib(_ n: Int) -> Int {
        if let result = cache[n] {
            return result 
        } else {
            let calculatedResult = fib(n - 1) + fib(n - 2)
            cache[n] = calculatedResult
            
            return calculatedResult
        }
    }
}

let solution = Solution()

assert(solution.fib(4) == 3)
assert(solution.fib(3) == 2)
assert(solution.fib(2) == 1)