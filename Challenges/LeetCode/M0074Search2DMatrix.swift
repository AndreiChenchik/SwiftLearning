class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let size = matrix[0].count * matrix.count
        
        return search(in: matrix, for: target, from: 0, to: size - 1)
    }
    
    func search(in matrix: [[Int]], for target: Int, from start: Int, to end: Int) -> Bool {
        guard end >= start else { return false }
        
        let sectionSize = end - start + 1 
        let midPoint = start + sectionSize / 2
        
        let width = matrix[0].count
        let midPointRow = midPoint / width
        let midPointColumn = midPoint % width
        
        let value = matrix[midPointRow][midPointColumn]
        
        if target == value {
            return true
        } else if target < value {
            return search(in: matrix, for: target, from: start, to: midPoint - 1)
        } else {
            return search(in: matrix, for: target, from: midPoint + 1, to: end)
        }
    }
}
