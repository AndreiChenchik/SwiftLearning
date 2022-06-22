class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let arraySize = nums.count
        
        for i in 0..<arraySize {
            for j in i+1..<arraySize {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }
        }
        
        return [-1, -1]
    }
}
