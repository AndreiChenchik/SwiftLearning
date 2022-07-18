import Foundation

// MARK: - 🛠 Модель данных теста
// - Здесь описана модель тестовых данных
// - ⚠️ Не меняйте этот код

public struct TestCase {
    let a: Int?
    let b: Int?
    let result: Int?
}

// MARK: - 🛠 Тестовые данные
// - Здесь описаны тестовые данные
// - ⚠️ Не меняйте этот код

extension Array where Element == TestCase {

    public static let `default`: [TestCase] = [
        TestCase(a: 2, b: 2, result: 4),
        TestCase(a: nil, b: 1, result: nil),
        TestCase(a: 10, b: nil, result: nil),
        TestCase(a: nil, b: nil, result: nil),
    ]
}
