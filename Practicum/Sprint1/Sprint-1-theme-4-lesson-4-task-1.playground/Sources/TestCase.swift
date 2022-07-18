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

    public static func `default`(_ input: Any) -> [TestCase] {
        return [
            TestCase(
                testFuntction: { type(of: input) == Int.self },
                successMessage: "variable sum is of a Int type",
                failureMessage: "vairable sum is NOT of a Int type. It has type \(type(of: input))"
            ),
            TestCase(
                testFuntction: { "\(input)" == "250" },
                successMessage: "variable sum is equal to 250",
                failureMessage: "variable sum is NOT equal to 250. Its value is \(input)"
            )
        ]
    }
}
