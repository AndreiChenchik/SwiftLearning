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

    public static func `default`(_ planet: SolutionProtocol) -> [TestCase] {
        let mirror = Mirror(reflecting: planet)

        return [
            TestCase(
                testFuntction: { mirror.displayStyle == .struct },
                successMessage: "earth is of an Struct type",
                failureMessage: "earth is NOT of an Struct type. It has type \(String(describing: mirror.displayStyle)))"
            ),
            TestCase(
                testFuntction: { "\(planet.description)" == "\(planet.name) \(planet.galaxy) \(planet.isPopulated)"},
                successMessage: "property description is initialized correctly",
                failureMessage: "property description is NOT initialized correctly. It's value is \(planet.description)"
            )
        ]
    }
}
