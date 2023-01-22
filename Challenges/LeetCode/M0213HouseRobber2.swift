class Solution {
    var cache = [[Int]: Int]()
    
    func rob(_ nums: [Int]) -> Int {
        let results = [
            robMax(from: 0, in: nums, size: nums.count-1),
            robMax(from: 1, in: nums, size: nums.count),
            robMax(from: 2, in: nums, size: nums.count)
        ]
        
        return results.max()!
    }
    
    func robMax(from start: Int, in houses: [Int], size: Int) -> Int {
        guard start < size else { return 0 }
        if let cached = cache[[start, size]] { return cached }
        
        let nextMax = max(
            robMax(from: start+2, in: houses, size: size), 
            robMax(from: start+3, in: houses, size: size)
        )
        
        let result = houses[start] + nextMax
        cache[[start, size]] = result
        
        return result
    }
}
