/// Given two strings `s` and `t`, return `true` _if_ `s` _is a **subsequence** of_ `t`_, or_ `false` _otherwise_.
/// 
/// A **subsequence** of a string is a new string that is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (i.e., `"ace"` is a subsequence of `"abcde"` while `"aec"` is not).
/// 
/// **Example 1:**
/// ```
/// Input: s = "abc", t = "ahbgdc"
/// Output: true
/// ```
/// 
/// **Example 2:**
/// ```
/// Input: s = "axc", t = "ahbgdc"
/// Output: false
/// ```
/// 
/// **Constraints:**
/// -   `0 <= s.length <= 100`
/// -   `0 <= t.length <= 104`
/// -   `s` and `t` consist only of lowercase English letters.

class Solution {
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        let subSize = s.count
        guard subSize > 0 else { return true }
        
        var subChar = extractChar(from: s, at: 0)
        var count = 0
        
        for char in t {
            if char == extractChar(from: s, at: count) {
                count += 1
            }
            
            if count == subSize {
                return true
            }
        }
        
        return false
    }
    
    func extractChar(from string: String, at idx: Int) -> String.Element {
        return string[string.index(string.startIndex, offsetBy: idx)]
    }
}
