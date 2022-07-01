class Solution {
    func reverseString(_ s: inout [Character]) {
        guard s.count > 1 else { return }
        
        var leftPointer = 0
        var rightPointer = s.count - 1
        
        for _ in 0...(s.count / 2 - 1) {
            (s[leftPointer], s[rightPointer]) = (s[rightPointer], s[leftPointer])
            
            leftPointer += 1
            rightPointer -= 1
        }
    }
}
