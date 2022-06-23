/// Given the `head` of a singly linked list, reverse the list, and return _the reversed list_.
/// 
/// **Example 1:**
/// ![](https://assets.leetcode.com/uploads/2021/02/19/rev1ex1.jpg)
/// ```
/// Input: head = [1,2,3,4,5]
/// Output: [5,4,3,2,1]
/// ```
/// 
/// **Example 2:**
/// ![](https://assets.leetcode.com/uploads/2021/02/19/rev1ex2.jpg)
/// ```
/// Input: head = [1,2]
/// Output: [2,1]
/// ```
/// 
/// **Example 3:**
/// ```
/// Input: head = []
/// Output: []
/// ```
/// 
/// **Constraints:**
/// -   The number of nodes in the list is the range `[0, 5000]`.
/// -   `-5000 <= Node.val <= 5000`

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var reversed = ListNode()
        var source = head
        
        var detached: ListNode? = nil
        
        while source != nil {
            detached = source
            source = source?.next
            
            detached?.next = reversed.next
            reversed.next = detached
        }
        
        return reversed.next
    }
}
