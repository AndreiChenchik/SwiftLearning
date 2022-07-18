import Foundation

// MARK: - 🛠 Исполнитель тестов
// - Здесь написан код выполняющий тесты
// - ⚠️ Не меняйте этот код

public struct TestRunner {

    private var solution: SolutionProtocol

    public init(solution: SolutionProtocol) {
        self.solution = solution
    }

    public mutating func runTests(testCases: [TestCase]) {
        print("▶️ Starting test run with \(testCases.count) test cases ...")

        var failedTestsIndexes: [Int] = []
        for (i, testCase) in testCases.enumerated() {
            print("\nRunning test case #\(i) of \(testCases.count)")

            solution.starShip = testCase.ship
            let name = solution.getShipName()
            if i == 0 {
                solution.addCrew(member: "Baz")
            }
            let first = solution.getFirstCrewMember()

            if name == testCase.result.name &&
                first == testCase.result.crew.first {
                print("✅ Test #\(i) passed")
            } else {
                failedTestsIndexes.append(i)

                print("❌ Test #\(i) failed")

                print("Expected: name to be \(testCase.result.name), but got \(name)\n firstMemeber to be  \(testCase.result.crew.first) but got \(first) ")
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
