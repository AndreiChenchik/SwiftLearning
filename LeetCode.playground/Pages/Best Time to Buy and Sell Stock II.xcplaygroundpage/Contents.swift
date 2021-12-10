//: [Previous](@previous)


// 4 errors
// - wrong declaration (not like in leetcode, input need to be anonymous)
// - {} for guard else block missing
// - .max instead of .max() in two places
// - no check for optionality while using max()
// not accepted - too slow!

class SolutionV1 {
    func maxProfit(_ prices: [Int]) -> Int {
        guard
            prices.count > 1
        else {
            return 0
        }

        var profits = [Int]()

        for i in 0..<prices.count-1 {
            guard let maxSellPrice = Array(prices[(i+1)...]).max() else {
                profits.append(0)
                continue
            }

            let possibleProfit = maxSellPrice - prices[i]

            profits.append(possibleProfit > 0 ? possibleProfit : 0)
        }

        if let maxProfit = profits.max() {
            return maxProfit
        } else {
            return 0
        }
    }
}

// Not accepted - wrong answer
class SolutionV2 {
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

let solution = SolutionV2()

assert(solution.maxProfit([7,1,5,3,6,4]) == 7)
assert(solution.maxProfit([1,2,3,4,5]) == 4)
assert(solution.maxProfit([7,6,4,3,1]) == 0)
assert(solution.maxProfit([7,1,5,3,6,4]) == 5)

