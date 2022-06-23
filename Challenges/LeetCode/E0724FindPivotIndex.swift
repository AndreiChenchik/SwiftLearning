class Solution {
    func pivotIndex(_ nums: [Int]) -> Int {
        let size = nums.count
        
        var cumSum = 0
        var cumSums = [Int]()
        
        for num in nums {
            cumSum += num
            cumSums.append(cumSum) 
        } 
        
        var left = 0
        var right = 0
        
        for item in 0..<size {
            left = item == 0 ? 0 : cumSums[item - 1]
            right = item == size - 1 ? 0 : cumSum - cumSums[item]
            
            if left == right {
                return item
            }
        }
        
        return -1
    }
}

let solution = Solution()
let result = solution.pivotIndex([1,7,3,6,5,6])
assert(result == 3)
