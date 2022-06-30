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
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var results = [Int]()
        
        if let node = root {
            results += inorderTraversal(root?.left)
            results.append(node.val)
            results += inorderTraversal(root?.right)
        }
        
        return results
    }
}
