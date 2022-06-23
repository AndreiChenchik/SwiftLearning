/// Given two strings `s` and `t`, _determine if they are isomorphic_.
/// 
/// Two strings `s` and `t` are isomorphic if the characters in `s` can be replaced to get `t`.
/// 
/// All occurrences of a character must be replaced with another character while preserving the order of characters. No two characters may map to the same character, but a character may map to itself.
/// 
/// **Example 1:**
/// ```
/// Input: s = "egg", t = "add"
/// Output: true
/// ```
/// 
/// **Example 2:**
/// ```
/// Input: s = "foo", t = "bar"
/// Output: false
/// ```
/// 
/// **Example 3:**
/// ```
/// Input: s = "paper", t = "title"
/// Output: true
/// ```
/// 
/// **Constraints:**
/// -   `1 <= s.length <= 5 * 104`
/// -   `t.length == s.length`
/// -   `s` and `t` consist of any valid ascii character.

class Solution {
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        return encode(s) == encode(t)
    }
    
    func encode(_ string: String) -> [Int] {
        var count = 0
        var encoder: [String.Element: Int] = [:]
        
        var result = [Int]()
        
        for char in string {
            if let code = encoder[char] {
                result.append(code)
            } else {
                encoder[char] = count
                result.append(count)
                
                count += 1
            }
        }
        
        
        return result
    }
}

let solution = Solution()
let result = solution.isIsomorphic("paper", "title")

assert(result == true)
