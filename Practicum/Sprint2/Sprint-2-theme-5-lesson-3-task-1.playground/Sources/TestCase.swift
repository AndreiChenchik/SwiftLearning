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

    public static func `default`(
        squareIsAreaCalculator: @escaping @autoclosure () -> Bool,
        squareSideLength: Double,
        squareArea: Double,
        circleIsAreaCalculator: @escaping @autoclosure () -> Bool,
        circleRadius: Double,
        circleArea: Double
    ) -> [TestCase] {
        let expectedSquareArea: Double = 2.0 * 2.0
        let expectedCircleArea: Double = 5.0 * 5.0 * Double.pi
        return [
            TestCase(
                testFuntction: squareIsAreaCalculator,
                successMessage: "variable square conforms to AreaCalculator protocol",
                failureMessage: "variable square does not conform to AreaCalculator protocol"
            ),
            TestCase(
                testFuntction: { squareSideLength == 2.0 },
                successMessage: "square side length equals to 2",
                failureMessage: "square side length does not equal to 5, it is \(circleRadius)"
            ),
            TestCase(
                testFuntction: { squareArea == expectedSquareArea },
                successMessage: "square area equals to \(expectedSquareArea)",
                failureMessage: "square area does not equal to \(expectedSquareArea), it is \(squareArea)"
            ),
            TestCase(
                testFuntction: circleIsAreaCalculator,
                successMessage: "variable circle conforms to AreaCalculator protocol",
                failureMessage: "variable circle does not conform to AreaCalculator protocol"
            ),
            TestCase(
                testFuntction: { circleRadius == 5.0 },
                successMessage: "circle radius equals to 5",
                failureMessage: "circle radius does not equal to 5, current radius is \(circleRadius)"
            ),
            TestCase(
                testFuntction: { circleArea == expectedCircleArea },
                successMessage: "circle area equals to \(expectedCircleArea)",
                failureMessage: "circle area does not equal to \(expectedCircleArea), current area is \(circleArea)"
            )
        ]
    }
}
