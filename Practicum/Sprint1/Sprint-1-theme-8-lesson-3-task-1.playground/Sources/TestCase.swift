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

    public static func `default`(_ planet: Any) -> [TestCase] {
        let mirror = Mirror(reflecting: planet)
        return [
            TestCase(
                testFuntction: { mirror.displayStyle == .enum },
                successMessage: "planet is of an Enum type",
                failureMessage: "planet is NOT of an Enum type. It has type \(String(describing: mirror.displayStyle)))"
            ),
            TestCase(
                testFuntction: { "\(planet)" == "earth" },
                successMessage: "variable planet is equal to earth",
                failureMessage: "variable planet is NOT equal to earth. Its value is \(planet)"
            )
        ]
    }
}
