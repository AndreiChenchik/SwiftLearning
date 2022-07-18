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

    public static func `default`(_ bread: Any, _ milk: Any, _ sum: Any) -> [TestCase] {
        return [
            TestCase(
                testFuntction: { type(of: bread) == Int.self },
                successMessage: "variable bread is of a Int type",
                failureMessage: "vairable bread is NOT of a Int type. It has type \(type(of: bread))"
            ),
            TestCase(
                testFuntction: { type(of: milk) == Double.self },
                successMessage: "variable milk is of a Double type",
                failureMessage: "vairable milk is NOT of a Double type. It has type \(type(of: milk))"
            ),
            TestCase(
                testFuntction: { type(of: sum) == Double.self },
                successMessage: "variable sum is of a Double type",
                failureMessage: "vairable sum is NOT of a Double type. It has type \(type(of: sum))"
            ),
            TestCase(
                testFuntction: { String(format: "%.2f", sum as! Double) == "64.99" },
                successMessage: "variable sum is of a Double type",
                failureMessage: "vairable sum is NOT of a Double type. It has type \(type(of: sum))"
            ),

        ]
    }
}
