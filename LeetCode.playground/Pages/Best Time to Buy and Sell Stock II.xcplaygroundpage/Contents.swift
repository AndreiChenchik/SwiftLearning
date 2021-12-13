//: [Previous](@previous)
//:
//: You are given an integer array `prices` where `prices[i]` is the price of a given stock on the `i-th` day.
//:
//: On each day, you may decide to buy and/or sell the stock. You can only hold **at most one** share of the stock at any time. However, you can buy it then immediately sell it on the **same day**.
//:
//: Find and return the **maximum** profit you can achieve.
//:
//: Constraints:
//:
//: * 1 <= prices.length <= 3 * 10^4
//: * 0 <= prices[i] <= 10^4


// SolutionV1 - Accepted
// Your runtime beats 100.00 % of swift submissions.
// https://leetcode.com/submissions/detail/601211367/
class SolutionV1 {
    func maxProfit(_ prices: [Int]) -> Int {
        var totalProfit = 0
        var purchasePrice = prices[0]
        var potentialSellPrice = prices[0]

        for price in prices {
            if price >= potentialSellPrice {
                potentialSellPrice = price
                continue
            } else {
                let profit = potentialSellPrice - purchasePrice
                totalProfit += profit > 0 ? profit : 0

                purchasePrice = price
                potentialSellPrice = price
            }
        }

        let profit = potentialSellPrice - purchasePrice
        totalProfit += profit > 0 ? profit : 0

        return totalProfit
    }
}

let solution = SolutionV1()

assert(solution.maxProfit([7,1,5,3,6,4]) == 7)
assert(solution.maxProfit([1,2,3,4,5]) == 4)
assert(solution.maxProfit([7,6,4,3,1]) == 0)

//: [Next](@next)
