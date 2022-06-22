import Foundation

/*
 * Complete the 'plusMinus' function below.
 *
 * The function accepts INTEGER_ARRAY arr as parameter.
 */

func plusMinus(arr: [Int]) -> Void {
    // Write your code here
    var (plus, minus, zero) = (0.0, 0.0, 0.0)
    
    for item in arr {
        switch item {
            case _ where item < 0:
                minus += 1
            case _ where item > 0:
                plus += 1
            default:
                zero += 1
        }
    }
    
    let total = plus + minus + zero
    
    print(String(format: "%.6f", plus/total))
    print(String(format: "%.6f", minus/total))
    print(String(format: "%.6f", zero/total))
}

guard let n = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

guard let arrTemp = readLine()?.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression) else { fatalError("Bad input") }

let arr: [Int] = arrTemp.split(separator: " ").map {
    if let arrItem = Int($0) {
        return arrItem
    } else { fatalError("Bad input") }
}

guard arr.count == n else { fatalError("Bad input") }

plusMinus(arr: arr)
