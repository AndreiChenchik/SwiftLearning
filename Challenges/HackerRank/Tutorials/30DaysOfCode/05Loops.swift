import Foundation



guard let n = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

var line: String

for x in 1...10 {
    line = String(format: "%d x %d = %d", n, x, n * x)
    print(line)
}
