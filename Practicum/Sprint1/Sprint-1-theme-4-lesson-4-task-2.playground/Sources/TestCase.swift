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

    public static func `default`(_ meat: Any, _ chicken: Any, _ cheapest: Any) -> [TestCase] {
        return [
            TestCase(
                testFuntction: { type(of: meat) == Int.self },
                successMessage: "variable meat is of a Int type",
                failureMessage: "vairable meat is NOT of a Int type. It has type \(type(of: meat))"
            ),
            TestCase(
                testFuntction: { type(of: chicken) == Int.self },
                successMessage: "variable chicken is of a Int type",
                failureMessage: "vairable chicken is NOT of a Int type. It has type \(type(of: chicken))"
            ),
            TestCase(
                testFuntction: { "\(cheapest)" == "300" },
                successMessage: "variable cheapest is equal to 300",
                failureMessage: "variable sum is NOT equal to 300. Its value is \(cheapest)"
            )
        ]
    }
}
