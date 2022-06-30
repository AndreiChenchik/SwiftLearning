/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    var result = [[Int]]()
    
    func fillResult(_ root: TreeNode?, _ counter: Int) {
        if let node = root {
            if result.count <= counter { result.append([Int]()) }
                
            result[counter].append(node.val)
            fillResult(node.left, counter + 1)
            fillResult(node.right, counter + 1)
        }
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var counter = 0 
        
        fillResult(root, counter)
        
        return result
    }
}
