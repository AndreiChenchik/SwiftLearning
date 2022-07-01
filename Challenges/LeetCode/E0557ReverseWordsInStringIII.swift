class Solution {
    func reverseWords(_ s: String) -> String {
        var result = Array(s)
        var wordStart = 0
        var wordEnd = 0
        
        var cursor = 0
        for char in result {
            if char == " " {
                wordEnd = cursor - 1
                reverseString(in: &result, from: wordStart, to: wordEnd)
                wordStart = cursor + 1
            }
            cursor += 1
        }
        reverseString(in: &result, from: wordStart, to: s.count-1)
        
        return String(result) 
    }
    
    func reverseString(in s: inout [Character], from start: Int, to end: Int) {
        let size = end - start + 1
        guard size > 1 else { return }
        
        var leftPointer = start
        var rightPointer = end
        
        for _ in 0...(size / 2 - 1) {
            (s[leftPointer], s[rightPointer]) = (s[rightPointer], s[leftPointer])
            
            leftPointer += 1
            rightPointer -= 1
        }
    }
}
