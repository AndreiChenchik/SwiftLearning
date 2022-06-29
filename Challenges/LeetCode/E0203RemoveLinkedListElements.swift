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
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        var node = head
        
        while node != nil {
            if let next = node?.next, next.val == val {
                node?.next = next.next
            } else {
                node = node?.next
            }
        }
        
        node = head
        if let value = node?.val, value == val {
            node = node?.next
        }
        
        return node
    }
}
