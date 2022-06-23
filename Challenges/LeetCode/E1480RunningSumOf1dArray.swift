class Solution {
    func runningSum(_ nums: [Int]) -> [Int] {
        var result = [Int]()
        var cumSum = 0 
        
        for num in nums {
            cumSum += num
            result.append(cumSum)
        }
        
        return result
    }
}

let solution = Solution()
let result = solution.runningSum([1,2,3,4])

print(result)
