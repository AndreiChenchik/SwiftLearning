class Solution {
    var cache = [0: 0, 1: 1, 2: 1]
    
    func tribonacci(_ n: Int) -> Int {
        if let result = cache[n] {
            return result 
        } else {
            let calculatedResult = tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3)
            cache[n] = calculatedResult
            
            return calculatedResult
        }
    }
}

let solution = Solution()

assert(solution.tribonacci(4) == 4)
assert(solution.tribonacci(25) == 1389537)