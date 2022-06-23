class Solution {
    func generate(_ numRows: Int) -> [[Int]] {
        var result = [[Int]]()
        var item = 0
        
        result.append([1])
        
        for row in 1..<numRows {
            result.append([1])
            
            for cell in 1..<row {
                item = result[row - 1][cell - 1] + result[row - 1][cell]
                result[row].append(item)    
            }
            
            result[row].append(1)
        }
        
        return result
    }
}

let solution = Solution()
let result = solution.generate(5)
print(result)
