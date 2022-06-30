class Solution {
    func isValid(_ s: String) -> Bool {
        let validParentheses: [String.Element: String.Element] = [
            ")": "(",
            "}": "{",
            "]": "["
        ]
        var stack = [String.Element]()
        
        for element in s {
            if let openParenthes = validParentheses[element] {
                if stack.count == 0 || openParenthes != stack.removeLast() {
                    return false
                }
            } else {
                stack.append(element)
            }
        }
        
        return stack.count == 0
    }
}
