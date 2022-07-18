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

    public static func `default`(_ astronaut: SolutionProtocol) -> [TestCase] {
        let mirror = Mirror(reflecting: astronaut)

        var changedAstronaut = astronaut
        changedAstronaut.setRole("New role")

        return [
            TestCase(
                testFuntction: { mirror.displayStyle == .struct },
                successMessage: "gagarin is of an Struct type",
                failureMessage: "gagarin is NOT of an Struct type. It has type \(String(describing: mirror.displayStyle)))"
            ),
            TestCase(
                testFuntction: { "\(changedAstronaut.role)" == "New role"},
                successMessage: "method setRole works correctly",
                failureMessage: "method setRole does NOT change property role"
            )
        ]
    }
}
