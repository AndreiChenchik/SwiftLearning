class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        let arraySize = nums.count 
        
        return search(in: nums, from: 0, to: arraySize - 1, for: target)
    }
    
    func search(in array: [Int], from start: Int, to end: Int, for target: Int) -> Int {
        guard end >= start else { return -1 }
        
        let size = end - start + 1
        let midPoint = start + size / 2
        
        if array[midPoint] == target { return midPoint } 
        if size == 1 { return -1 }
        
        let left = search(in: array, from: start, to: midPoint - 1, for: target)
        let right = search(in: array, from: midPoint + 1, to: end, for: target)
        
        let result = left != -1 ? left : right
        
        return result
    }
}
