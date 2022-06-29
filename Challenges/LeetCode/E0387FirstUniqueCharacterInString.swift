class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var counts = [String.Element: Int]()
        
        for char in s {
            counts[char] = (counts[char] ?? 0) + 1
        }

        var counter = 0
        for char in s {
            if counts[char]! == 1 {
                return counter
            }
            
            counter += 1
        }
        
        return -1
    }
}
