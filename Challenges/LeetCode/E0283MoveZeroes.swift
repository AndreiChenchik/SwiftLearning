/// Given an integer array `nums`, move all `0`'s to the end of it while maintaining the relative order of the non-zero elements.
/// 
/// **Note** that you must do this in-place without making a copy of the array.
/// 
/// **Example 1:**
/// ```
/// Input: nums = [0,1,0,3,12]
/// Output: [1,3,12,0,0]
/// ```
/// 
/// **Example 2:**
/// ```
/// Input: nums = [0]
/// Output: [0]
/// ```
/// 
/// **Constraints:**
/// -   `1 <= nums.length <= 104`
/// -   `-231 <= nums[i] <= 231 - 1`

class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        let size = nums.count
        
        var counter = 0
        
        for idx in 0..<size {
            if nums[idx] != 0 {
                (nums[counter], nums[idx]) = (nums[idx], nums[counter])
                counter += 1
            }
        }
    }
}
