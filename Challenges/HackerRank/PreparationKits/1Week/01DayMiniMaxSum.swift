import Foundation

/*
 * Complete the 'miniMaxSum' function below.
 *
 * The function accepts INTEGER_ARRAY arr as parameter.
 */

func miniMaxSum(arr: [Int]) -> Void {
    var (min, max) = (arr[0], arr[0])
    var sum: Int64 = 0
    
    for item in arr {
        if item < min {
            min = item
        } else if item > max {
            max = item
        }
        
        sum += Int64(item)
    }

    print(String(format:"%ld %ld", sum - Int64(max), sum - Int64(min)))
}

guard let arrTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

let arr: [Int] = arrTemp.split(separator: " ").map {
    if let arrItem = Int($0) {
        return arrItem
    } else { fatalError("Bad input") }
}

guard arr.count == 5 else { fatalError("Bad input") }

miniMaxSum(arr: arr)
