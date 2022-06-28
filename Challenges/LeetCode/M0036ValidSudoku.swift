class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        let boardSize = board.count
        
        let block = Array(repeating: false, count: boardSize)        
        var rows = Array(repeating: block, count: boardSize)
        var columns = Array(repeating: block, count: boardSize)
        var boxes = Array(repeating: block, count: boardSize)
        
        var box = 0        
        for row in 0..<boardSize {
            for column in 0..<boardSize {
                guard let digit = board[row][column].wholeNumberValue else { continue }

                let digitIdx = digit - 1
                box = (row / 3) * 3 + column / 3
                
                if rows[row][digitIdx] || columns[column][digitIdx] || boxes[box][digitIdx] {
                    return false
                } 

                rows[row][digitIdx] = true
                columns[column][digitIdx] = true
                boxes[box][digitIdx] = true
            }
        }
        
        
        return true
    }
}

let solution = Solution()

let board: [[Character]] = 
[["5","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]

print(solution.isValidSudoku(board))