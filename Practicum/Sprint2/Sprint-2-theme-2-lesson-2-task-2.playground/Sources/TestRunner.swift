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
            print("\nRunning test case #\(i) of \(testCases.count)")

            solution.save(id: testCase.id)

            if solution.id == testCase.result {
                print("✅ Test #\(i) passed")
            } else {
                failedTestsIndexes.append(i)

                print("❌ Test #\(i) failed")
                print("Expected id to be \(testCase.result), but got \(solution.id)")
            }
        }

        print("\n⏹ Finishing test run...\n")
        if failedTestsIndexes.isEmpty {
            print("✅ All \(testCases.count) test passed")
        } else {
            print("❌ Test run failed for \(failedTestsIndexes.count) of \(testCases.count) test cases")

            let failedTestCaseIDsString = failedTestsIndexes
                .map { "#\($0)" }
                .joined(separator: ", ")
            print("Failed test cases are: \(failedTestCaseIDsString)")
        }
    }
}
