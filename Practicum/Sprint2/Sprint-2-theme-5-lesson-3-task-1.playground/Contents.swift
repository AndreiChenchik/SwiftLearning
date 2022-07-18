import Foundation

// MARK: - ℹ️ Инструкция
//
// Чтобы выполнить практическое задание, вам потребуется:
// 1. Прочитайте условие задания
// 2. Напишите ваше решение ниже в этом файле в разделе "Решение".
// 3. После того как решение будет готово, запустите Playground,
//    чтобы проверить свое решение тестами

// MARK: - ℹ️ Условие задания
//
// 1. Определите протокол AreaCalculator и в нем метод getArea(),
//    который будет вычислять площадь фигуры и возвращать Double.
//
// 2. Определите два класса Square и Circle,
//    которые будут реализовывать протокол AreaCalculator.
//  - Класс Square содержит информацию о длине стороны квадрата в константе sideLength: Double
//  - Класс Circle содержит информацию о радиусе круга в константе radius: Double
//
// 3. Создайте квадрат со стороной 2 и сохраните его в константу square,
//    посчитайте площадь квадрата и сохраните его в константу squareArea.
//
// 4. Создайте круг с радиусом 5 и сохраните его в константу circle,
//    посчитайте площадь круга и сохраните её в константу circleArea.
//

// MARK: - 🧑‍💻 Решение
// --- НАЧАЛО КОДА С РЕШЕНИЕМ ---
protocol AreaCalculator {
    func getArea() -> Double
}

class Square: AreaCalculator {
    var sideLength: Double
    
    init(sideLength: Double) {
        self.sideLength = sideLength
    }
    
    func getArea() -> Double {
        sideLength * sideLength
    }
}

class Circle: AreaCalculator {
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    func getArea() -> Double {
        radius * radius * .pi
    }
}

var square = Square(sideLength: 2)
var squareArea = square.getArea()
var circle = Circle(radius: 5)
var circleArea = circle.getArea()
// --- КОНЕЦ КОДА С РЕШЕНИЕМ ---

// MARK: - 🛠 Тесты
// - Здесь содержится код запуска тестов для вашего решения
// - ⚠️ Не меняйте этот код

TestRunner.runTests(
    .default(
        squareIsAreaCalculator: square is AreaCalculator,
        squareSideLength: square.sideLength,
        squareArea: squareArea,
        circleIsAreaCalculator: circle is AreaCalculator,
        circleRadius: circle.radius,
        circleArea: circleArea
    )
)
