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

    public static func `default`(_ productA: Any, _ productB: Any, _ sum: Any) -> [TestCase] {
        return [
            TestCase(
                testFuntction: { type(of: productA) == Double.self },
                successMessage: "variable bread is of a Double type",
                failureMessage: "vairable bread is NOT of a Double type. It has type \(type(of: productA))"
            ),
            TestCase(
                testFuntction: { type(of: productB) == Double.self },
                successMessage: "variable milk is of a Double type",
                failureMessage: "vairable milk is NOT of a Double type. It has type \(type(of: productB))"
            ),
            TestCase(
                testFuntction: { type(of: sum) == Double.self },
                successMessage: "variable sum is of a Double type",
                failureMessage: "vairable sum is NOT of a Double type. It has type \(type(of: sum))"
            ),
            TestCase(
                testFuntction: { String(format: "%.2f", productB as! Double) == "39.99" },
                successMessage: "variable milk is equal to 39.99",
                failureMessage: "variable milk is NOT equal to 39.99. Its value is \(String(format: "%.2f"))"
            ),
            TestCase(
                testFuntction: { "\(productA)" == "25.0" },
                successMessage: "variable bread is equal to 25",
                failureMessage: "variable bread is NOT equal to 25. Its value is \(productA)"
            ),
            TestCase(
                testFuntction: { String(format: "%.2f", sum as! Double) == "64.99" },
                successMessage: "variable sum is equal to 64.99",
                failureMessage: "variable sum is NOT equal to 64.99. Its value is \(String(format: "%.2f"))"
            )
        ]
    }
}
