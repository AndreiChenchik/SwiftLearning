class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var availableLetters = [String.Element: Int]()
        var counter = 0
        
        for char in t {
            availableLetters[char] = (availableLetters[char] ?? 0) + 1
            counter += 1
        }
        
        for char in s {
            availableLetters[char] = (availableLetters[char] ?? 0) - 1
            
            if availableLetters[char]! < 0 {
                return false
            }
            
            counter -= 1
        }
        
        return counter == 0
    }
}
