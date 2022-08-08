class Solution {
    var cache = [0: 1]

    func climbStairs(_ n: Int) -> Int {    
        if n < 0 { return 0 } // wrong direction
        if let cached = cache[n] { return cached }
        
        let result = climbStairs(n - 1) + climbStairs(n - 2)
        cache[n] = result
        
        return result
    }
}