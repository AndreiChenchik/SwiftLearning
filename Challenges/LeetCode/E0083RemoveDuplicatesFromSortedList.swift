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
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        var node = head
        
        while node != nil {
            if let value = node?.val, let valueNext = node?.next?.val, value == valueNext {
                node?.next = node?.next?.next
            } else {
                node = node?.next
            }
        }
        
        return head
    }
}
