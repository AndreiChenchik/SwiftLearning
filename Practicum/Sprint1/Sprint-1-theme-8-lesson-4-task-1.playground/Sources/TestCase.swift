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

    public static func `default`(_ object: Any, _ objectName: Any) -> [TestCase] {
        let mirror = Mirror(reflecting: object)
        return [
            TestCase(
                testFuntction: { mirror.displayStyle == .enum },
                successMessage: "moon is of an Enum type",
                failureMessage: "moon is NOT of an Enum type. It has type \(String(describing: mirror.displayStyle)))"
            ),
            TestCase(
                testFuntction: { type(of: objectName) == String.self },
                successMessage: "objectName is of an String type",
                failureMessage: "objectName is NOT of an Enum type. It has type \(type(of: objectName)))"
            ),
            TestCase(
                testFuntction: { "\(object)" == "satelite(1737.4, \"Луна\")" },
                successMessage: "variable moon is equal to \"satelite(1737.4, \"Луна\")\"",
                failureMessage: "variable moon is NOT equal to \"satelite(1737.4, \"Луна\")\" . It's value is \(object))"
            ),
        ]
    }
}
