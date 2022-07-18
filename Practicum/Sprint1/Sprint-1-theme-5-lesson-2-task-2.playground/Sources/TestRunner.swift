import Foundation

// MARK: - 🛠 Исполнитель тестов
// - Здесь написан код выполняющий тесты
// - ⚠️ Не меняйте этот код

public struct TestRunner {

    private let solution: SolutionProtocol

    public init(solution: SolutionProtocol) {
        self.solution = solution
    }

    public func runTests(testCases: [TestCase]) {
        print("▶️ Starting test run with \(testCases.count) test cases ...")

        var failedTestsIndexes: [Int] = []
        for (i, testCase) in testCases.enumerated() {
            print("\nRunning test case #\(i + 1) of \(testCases.count)")

            let result = solution.findMinAndMax(in: testCase.array)

            if result == testCase.result {
                print("✅ Test #\(i + 1) passed")
            } else {
                failedTestsIndexes.append(i)

                print("❌ Test #\(i + 1) failed")
                
                if result.min != testCase.result.min {
                    print("Expected minimum in array \(testCase.array) has to be \(testCase.result.min), but got \(result.min)")
                }
                
                if result.max != testCase.result.max {
                    print("Expected maximum in array \(testCase.array) has to be \(testCase.result.max), but got \(result.max)")
                }
            }
        }

        print("\n⏹ Finishing test run...\n")
        if failedTestsIndexes.isEmpty {
            print("✅ All \(testCases.count) test passed")
        } else {
            print("❌ Test run failed for \(failedTestsIndexes.count) of \(testCases.count) test cases")

            let failedTestCaseIDsString = failedTestsIndexes
                .map { "#\($0 + 1)" }
                .joined(separator: ", ")
            print("Failed test cases are: \(failedTestCaseIDsString)")
        }
    }
}
