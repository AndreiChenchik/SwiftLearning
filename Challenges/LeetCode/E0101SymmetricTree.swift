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
    func isSymmetricNodes(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if let left = left, let right = right, left.val == right.val {
            return isSymmetricNodes(left.right, right.left) && isSymmetricNodes(left.left, right.right)  
        } else if left == nil && right == nil {
            return true
        } else {
            return false
        }   
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
       if let node = root {
           return isSymmetricNodes(node.left, node.right)
       } else {
           return true
       }
    }
}
