//: [Previous](@previous)

//: [Find Numbers with Even Number of Digits at leetcode.com](https://leetcode.com/explore/learn/card/fun-with-arrays/521/introduction/3237/)
//:
//: ![Find Numbers with Even Number of Digits](findNumbersWithEvenNumberDigits.jpeg align="left")_

class Solution {
    func findNumbers(_ nums: [Int]) -> Int {
        var evenDigitNums = 0
        for num in nums {
            if hasEvenDigits(num) {
                evenDigitNums += 1
            }
        }
        return evenDigitNums
    }
    
    private func hasEvenDigits(_ num: Int) -> Bool {
        var digits = 1
        var divider = 10
        
        while num / divider >= 1 {
            digits += 1
            divider *= 10
        }
        
        return digits % 2 == 0
    }
}

let solution = Solution()

assert(solution.findNumbers([12,345,2,6,7896]) == 2)
assert(solution.findNumbers([555,901,482,1771]) == 1)


//: [Next](@next)
