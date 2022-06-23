/// Given an array, rotate the array to the right by `k` steps, where `k` is non-negative.
/// 
/// **Example 1:**
/// ```
/// Input: nums = [1,2,3,4,5,6,7], k = 3
/// Output: [5,6,7,1,2,3,4]
/// Explanation:
/// rotate 1 steps to the right: [7,1,2,3,4,5,6]
/// rotate 2 steps to the right: [6,7,1,2,3,4,5]
/// rotate 3 steps to the right: [5,6,7,1,2,3,4]
/// ```
/// 
/// **Example 2:**
/// ```
/// Input: nums = [-1,-100,3,99], k = 2
/// Output: [3,99,-1,-100]
/// Explanation: 
/// rotate 1 steps to the right: [99,-1,-100,3]
/// rotate 2 steps to the right: [3,99,-1,-100]
/// ```
/// 
/// **Constraints:**
/// -   `1 <= nums.length <= 10^5`
/// -   `-2^31 <= nums[i] <= 2^31 - 1`
/// -   `0 <= k <= 10^5`

class Solution {
    func rotate(_ nums: inout [Int], _ k: Int) {
        let size = nums.count
        let shift = k % size
        guard size > 1, shift > 0 else { return }
        
        var buffer = Array(nums[..<shift])
        var bufIdx = 0
        
        var numIdx = shift
        for _ in 0..<size {
            (buffer[bufIdx], nums[numIdx]) = (nums[numIdx], buffer[bufIdx])
            
            numIdx = (numIdx + 1) % size
            bufIdx = (bufIdx + 1) % shift
        }
    }
}

