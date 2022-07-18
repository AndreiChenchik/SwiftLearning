import Foundation

// MARK: - 🛠 Модель данных теста
// - Здесь описана модель тестовых данных
// - ⚠️ Не меняйте этот код

public struct TestCase {

    let array: [Int]
    let result: (min: Int, max: Int)
}

// MARK: - 🛠 Тестовые данные
// - Здесь описаны тестовые данные
// - ⚠️ Не меняйте этот код

extension Array where Element == TestCase {

    public static let `default`: [TestCase] = [
        TestCase(array: [0], result: (min: 0, max: 0)),
        TestCase(array: [0, 1, 2], result: (min: 0, max: 2)),
        TestCase(array: [1, 0, 2], result: (min: 0, max: 2)),
        TestCase(array: [1, 2, 0], result: (min: 0, max: 2)),
        TestCase(array: [1, 1, 1], result: (min: 1, max: 1)),
        TestCase(array: [-1, 0, 2], result: (min: -1, max: 2)),
        TestCase(array: [-1, -2, -3], result: (min: -3, max: -1)),
    ]
}
