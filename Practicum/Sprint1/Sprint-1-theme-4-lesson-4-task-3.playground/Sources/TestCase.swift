import Foundation

// MARK: - 🛠 Модель данных теста
// - Здесь описана модель тестовых данных
// - ⚠️ Не меняйте этот код

public struct TestCase {

    let testFuntction: () -> Bool
    let successMessage: String
    let failureMessage: String
}

// MARK: - 🛠 Тестовые данные
// - Здесь описаны тестовые данные
// - ⚠️ Не меняйте этот код

extension Array where Element == TestCase {

    public static func `default`(_ age: Any, _ price: Any, _ maxProducts: Any) -> [TestCase] {
        return [
            TestCase(
                testFuntction: { type(of: age) == ClosedRange<Int>.self },
                successMessage: "variable age is of a ClosedRange<Int> type",
                failureMessage: "vairable age is NOT of a ClosedRange<Int> type. It has type \(type(of: age))"
            ),
            TestCase(
                        testFuntction: { "\(age)" == "1...100" },
                        successMessage: "variable age is equal to 1...100",
                        failureMessage: "variable age is NOT equal to 1...100. Its value is \(age)"
                    ),
            TestCase(
                testFuntction: { type(of: price) == Range<Int>.self },
                successMessage: "variable price is of a Range<Int> type",
                failureMessage: "vairable price is NOT of a Range<Int> type. It has type \(type(of: price))"
            ),
            TestCase(
                testFuntction: { "\(price)" == "100..<1000" },
                successMessage: "variable price is equal to 100..<1000",
                failureMessage: "variable price is NOT equal to 100..<1000. Its value is \(price)"
            ),
            TestCase(
                testFuntction: { type(of: maxProducts) == PartialRangeUpTo<Int>.self },
                successMessage: "variable maxProducts is of a PartialRangeUpTo<Int>(upperBound: 10) type",
                failureMessage: "vairable maxProducts is NOT of a PartialRangeUpTo<Int>(upperBound: 10) type. It has type \(type(of: maxProducts))"
            ),
            TestCase(
                testFuntction: { "\(maxProducts)" == "PartialRangeUpTo<Int>(upperBound: 10)" },
                successMessage: "variable maxProducts is equal to PartialRangeUpTo<Int>(upperBound: 10)",
                failureMessage: "variable maxProducts is NOT equal to PartialRangeUpTo<Int>(upperBound: 10). Its value is \(maxProducts)"
            ),

        ]
    }
}
