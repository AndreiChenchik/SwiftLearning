class Solution {
    var cache = [Int: Int]()
    
    func rob(_ nums: [Int]) -> Int {
        return max(robMax(from: 0, in: nums), robMax(from: 1, in: nums))
    }
    
    func robMax(from start: Int, in houses: [Int]) -> Int {
        guard start < houses.count else { return 0 }
        if let cached = cache[start] { return cached }
        
        let nextMax = max(
            robMax(from: start+2, in: houses), 
            robMax(from: start+3, in: houses)
        )
        
        let result = houses[start] + nextMax
        cache[start] = result
        
        return result
    }
}
