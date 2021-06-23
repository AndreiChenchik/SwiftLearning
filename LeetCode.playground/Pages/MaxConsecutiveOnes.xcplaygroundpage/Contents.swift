//: [Previous](@previous)

//: [Max Consecutive Ones at leetcode.com](https://leetcode.com/explore/learn/card/fun-with-arrays/521/introduction/3238/)
//:
//: ![Max Consecutive Ones](maxConsecutiveOnes.jpeg align="left")_

class Solution {
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var max = 0
        var counter = 0
        
        for number in nums {
            if number == 0 {
                if counter > max {
                    max = counter
                }
                
                counter = 0
            } else {
                counter += 1
            }
        }
        
        if counter > max {
            max = counter
        }
        
        return max
    }
}

let solution = Solution()
assert(solution.findMaxConsecutiveOnes([1,1,0,1,1,1]) == 3)
assert(solution.findMaxConsecutiveOnes([1,0,1,1,0,1]) == 2)
//: [Next](@next)
