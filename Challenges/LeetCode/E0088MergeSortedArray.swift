class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var n1 = m - 1
        var n2 = n - 1
        var n3 = m + n - 1
        var nextItem = 0
        
        
        while n3 >= 0 {
            if n2 < 0 || (n1 >= 0 && nums1[n1] > nums2[n2]) {
                nextItem = nums1[n1]
                n1 -= 1
            } else {
                nextItem = nums2[n2]
                n2 -= 1
            }      
            
            
            nums1[n3] = nextItem
            n3 -= 1
        }
        
    }
}
