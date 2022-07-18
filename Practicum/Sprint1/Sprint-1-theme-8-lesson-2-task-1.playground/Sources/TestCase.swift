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

    public static func `default`(_ specie: Any, _ description: Any) -> [TestCase] {
        let mirror = Mirror(reflecting: specie)
        return [
            TestCase(
                testFuntction: { mirror.displayStyle == .enum },
                successMessage: "specie is of an Enum type",
                failureMessage: "specie is NOT of an Enum type. It has type \(String(describing: mirror.displayStyle)))"
            ),
            TestCase(
                testFuntction: { "\(description)" == "Рыба" },
                successMessage: "variable description is equal to \"Рыба\"",
                failureMessage: "variable description is NOT equal to \"Рыба\". Its value is \(description)"
            )
        ]
    }
}
