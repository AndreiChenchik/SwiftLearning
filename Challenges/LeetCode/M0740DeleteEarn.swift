class Solution {
    func shouldTakeIt(_ num: Int, _ sums: [Int: Int]) -> Bool {
        let neighbours = sums[num-1, default: 0] + sums[num+1, default: 0]
        
        return sums[num, default: 0] > neighbours
    }
    
    func deleteAndEarn(_ nums: [Int]) -> Int {
        var sums = [Int: Int]()
        nums.forEach { sums[$0, default: 0] += $0 }
        
        var result = 0
        
        while sums.keys.count > 0 {
            print(sums)
            for num in sums.keys {
                print(num)
                if shouldTakeIt(num, sums) {
                    result += sums[num, default: 0]
                    sums.removeValue(forKey: num-1)
                    sums.removeValue(forKey: num)
                    sums.removeValue(forKey: num+1)
                }
            }
        }
        
        return result
    }
}

let solution = Solution()

let case1 = [8,3,4,7,6,6,9,2,5,8,2,4,9,5,9,1,5,7,1,4]
print(solution.deleteAndEarn(case1))