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

    public static func `default`(_ input: Double) -> [TestCase] {
        return [
            TestCase(
                testFuntction: { input == 89.6 },
                successMessage: "farenheit value is correct",
                failureMessage: "farenheit value is NOT correct. It equals to \(input)"
            )
        ]
    }
}
