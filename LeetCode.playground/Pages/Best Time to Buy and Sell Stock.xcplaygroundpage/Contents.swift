//: [Previous](@previous)


// 4 errors
// - wrong declaration (not like in leetcode, input need to be anonymous)
// - {} for guard else block missing
// - .max instead of .max() in two places
// - no check for optionality while using max()
// not accepted - too slow!
// 204 / 211 test cases passed.
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



// 4 errors
// - .length instead of .count
// - typo after renaming a array storing maxSellPrices
// - type "price[day]" instead of "prices[day]"
// Not accepted - too slow!
// 205 / 211 test cases passed.
class SolutionV2 {
    func maxProfit(_ prices: [Int]) -> Int {
        var maxSellPrices: [Int] = []

        for day in 0..<prices.count {
            maxSellPrices.append(prices[day])

            for pastDay in 0..<day {
                if prices[day] > maxSellPrices[pastDay] {
                    maxSellPrices[pastDay] = prices[day]
                }
            }
        }

        var profit = 0

        for day in 0..<prices.count {
            let possibleProfit = maxSellPrices[day] - prices[day]

            if possibleProfit > profit {
                profit = possibleProfit
            }
        }

        return profit
    }
}

let solution = SolutionV2()

assert(solution.maxProfit([7,1,5,3,6,4]) == 5)
assert(solution.maxProfit([7,6,4,3,1]) == 0)

