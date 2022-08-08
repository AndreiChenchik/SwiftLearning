class Solution {
    var cache = [Int: Int]()
    
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        let minCost = min(
            minCostClimbing(from: 0, in: cost),
            minCostClimbing(from: 1, in: cost)
        )
        
        return minCost
    }
    
    func minCostClimbing(from start: Int, in costs: [Int]) -> Int {
        guard start < costs.count else { return 0 }
        if let cached = cache[start] { return cached }
        
        
        let minCost = costs[start] + min(
            minCostClimbing(from: start + 1, in: costs),
            minCostClimbing(from: start + 2, in: costs)
        )
        
        cache[start] = minCost
        
        return minCost
    }
}
