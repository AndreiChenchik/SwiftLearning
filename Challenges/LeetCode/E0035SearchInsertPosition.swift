class Solution {
    var array = [Int]()
    var searchTarget = 0
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        searchTarget = target
        array = nums
        
        let size = array.count
        
        return searchInsertPosition(from: 0, to: size - 1)
    }
    
    func searchInsertPosition(from start: Int, to end: Int) -> Int {
        let size = end - start + 1        
        
        if size == 0 {
            return start
        }
        
        let mid = start + size / 2
        let midItem = array[mid]
        
        if midItem == searchTarget {
            return mid
        } else if searchTarget < midItem {
            return searchInsertPosition(from: start, to: mid - 1)
        } else {
            return searchInsertPosition(from: mid + 1, to: end)
        }        
    }
}
