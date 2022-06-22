class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        var bestDeal = 0
        
        var buyPrice = prices[0]
        var newDeal = 0
        
        for price in prices {
            if price < buyPrice {
                buyPrice = price
            }
            
            newDeal = price - buyPrice
            if newDeal > bestDeal {
                bestDeal = newDeal
            }
        }
        
        return bestDeal
    }
}
