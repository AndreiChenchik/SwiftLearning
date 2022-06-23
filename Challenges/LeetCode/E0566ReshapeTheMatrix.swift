class Solution {
    func matrixReshape(_ mat: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
        let size = mat.count * mat[0].count
        guard size == r * c else { return mat }
        
        var result = [[Int]]()
        var counter = 0
        
        var (row, column) = (0, 0)
        
        for matRow in mat {
            for matItem in matRow {
                row = counter / c
                column = counter % c
                
                if column == 0 {
                    result.append([matItem])
                } else {
                    result[row].append(matItem)
                }

                counter += 1
            }
        }
        
        return result
    }
}

let solution = Solution()
let result = solution.matrixReshape([[1,2],[3,4]], 1, 4)
print(result)