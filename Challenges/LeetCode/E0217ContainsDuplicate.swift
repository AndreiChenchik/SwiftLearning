class Solution {
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var appearances: [Int: Bool] = [:]
        
        for num in nums {
            guard appearances[num] == nil else { return true }
            
            appearances[num] = true
        }
        
        return false
    }
}
