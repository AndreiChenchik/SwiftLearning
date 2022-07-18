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

    public static func `default`(_ shipPart: Any) -> [TestCase] {
        let mirror = Mirror(reflecting: shipPart)
        return [
            TestCase(
                testFuntction: { mirror.displayStyle == .enum },
                successMessage: "part is of an Enum type",
                failureMessage: "part is NOT of an Enum type. It has type \(String(describing: mirror.displayStyle)))"
            ),
            TestCase(
                testFuntction: { "\(shipPart)" == "head" },
                successMessage: "variable age is equal to 101",
                failureMessage: "variable age is NOT equal to 101. Its value is \(shipPart)"
            )
        ]
    }
}
