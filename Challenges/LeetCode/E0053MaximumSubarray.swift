class Solution {
    var maxSum = 0
    var currentSum = 0
    
    func maxSubArray(_ nums: [Int]) -> Int {
        maxSum = nums[0]
        
        for num in nums {
            currentSum += num
           
            if num > currentSum {
                currentSum = num
            }
            
            if maxSum < currentSum {
                maxSum = currentSum
            }
        }
        
        return maxSum
    }
}
