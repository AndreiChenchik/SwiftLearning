/**
 * The knows API is defined in the parent class VersionControl.
 *     func isBadVersion(_ version: Int) -> Bool{}
 */

class Solution : VersionControl {
    func firstBadVersion(_ n: Int) -> Int {
        var version = n
        
        while version > 0 {
            if !isBadVersion(version) {
                break
            }
            
            version -= 1
        }
        
        return version + 1
    }
}
