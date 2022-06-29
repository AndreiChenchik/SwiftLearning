class Solution {
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var availableLetters = [String.Element: Int]()
        
        for char in magazine {
            availableLetters[char] = (availableLetters[char] ?? 0) + 1
        }
        
        for char in ransomNote {
            availableLetters[char] = (availableLetters[char] ?? 0) - 1
            
            if availableLetters[char]! < 0 {
                return false
            }
        }
        
        return true
    }
}
