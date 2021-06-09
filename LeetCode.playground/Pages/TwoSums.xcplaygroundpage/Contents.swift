//: [Previous](@previous)

//: [Two Sums at leetcode.com](https://leetcode.com/problems/two-sum/)
//: 
//: ![Two Sums](twoSums.png align="left")_

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<nums.count {
            for j in i+1..<nums.count {
                if nums[i]+nums[j] == target {
                    return [i, j]
                }
            }
        }
        
        return [Int]()
    }
}

let solution = Solution()

assert(solution.twoSum([2, 7, 11, 15], 9) == [0, 1])
assert(solution.twoSum([3, 2, 4], 6) == [1, 2])
assert(solution.twoSum([3, 3], 6) == [0, 1])


print(solution.twoSum([2, 7, 11, 15], 9))

//: [Next](@next)
