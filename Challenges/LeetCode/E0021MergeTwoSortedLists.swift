/// You are given the heads of two sorted linked lists `list1` and `list2`.
/// 
/// Merge the two lists in a one **sorted** list. The list should be made by splicing together the nodes of the first two lists.
/// 
/// Return _the head of the merged linked list_.
/// 
/// **Example 1:**
/// ![](https://assets.leetcode.com/uploads/2020/10/03/merge_ex1.jpg)
/// ```
/// Input: list1 = [1,2,4], list2 = [1,3,4]
/// Output: [1,1,2,3,4,4]
/// ```
/// 
/// **Example 2:**
/// ```
/// Input: list1 = [], list2 = []
/// Output: []
/// ```
/// 
/// **Example 3:**
/// ```
/// Input: list1 = [], list2 = [0]
/// Output: [0]
/// ```
/// 
/// **Constraints:**
/// -   The number of nodes in both lists is in the range `[0, 50]`.
/// -   `-100 <= Node.val <= 100`
/// -   Both `list1` and `list2` are sorted in **non-decreasing** order.

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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var (first, second) = (list1, list2)
        
        let start = ListNode()
        var current: ListNode? = start 
        
        while first != nil || second != nil {
            guard let firstItem = first else {
                current?.next = second
                second = second?.next
                current = current?.next
                continue
            }
            
            guard let secondItem = second else {
                current?.next = first
                first = first?.next
                current = current?.next
                continue                
            }
            
            if firstItem.val < secondItem.val {
                current?.next = firstItem
                first = firstItem.next
            } else {
                current?.next = secondItem
                second = secondItem.next
            }
            
            current = current?.next
        }
        
        return start.next
    }
}
