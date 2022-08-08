class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var cache = [Int: Int]()
        
        for (index, num) in nums.enumerated() {
            let secondNum = target - num
            
            if let secondIndex = cache[secondNum] {
                return [index, secondIndex]
            }
            
            cache[num] = index
        }
        
        return [-1, -1]
    }
}
