class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var numCounts: [Int: Int] = [:]
        var intersection: [Int] = []
        
        for num in nums1 {
            if let count = numCounts[num] {
                numCounts[num] = count + 1 
            } else {
                numCounts[num] = 1
            }
        }
        
        for num in nums2 {
            if let count = numCounts[num], count > 0 {
                numCounts[num] = count - 1
                intersection.append(num)
            }
        }
        
        return intersection
    }
}
