import Foundation

// MARK: - 🛠 Модель данных теста
// - Здесь описана модель тестовых данных
// - ⚠️ Не меняйте этот код

public struct TestCase {
    let id: String?
    let result: String?
}

// MARK: - 🛠 Тестовые данные
// - Здесь описаны тестовые данные
// - ⚠️ Не меняйте этот код

extension Array where Element == TestCase {

    public static let `default`: [TestCase] = [
        TestCase(id: "123", result: "123"),
        TestCase(id: nil, result: "Unknown")
    ]
}
