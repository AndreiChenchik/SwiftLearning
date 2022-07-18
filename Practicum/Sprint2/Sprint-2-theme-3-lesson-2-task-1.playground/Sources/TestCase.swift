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
        _ iphone: SolutionProtocol,
        _ samsung: SolutionProtocol
    ) -> [TestCase] {
        let iphone = iphone
        let samsung = samsung
        let newIphoneName = "new name"

        return [
            TestCase(
                testFuntction: { 
                    iphone.rename(newName: newIphoneName)
                    return iphone.name == newIphoneName
                },
                successMessage: "property `name` of iphone has correct value after calling rename(newName:)",
                failureMessage: "property `name` of iphone has INCORRECT value after calling rename(newName:). It's value is \(iphone.name), but must be \(newIphoneName)"
            ),
            TestCase(
                testFuntction: {
                    iphone.update(newOS: OS.iOS(version: "16.0"))
                    if
                        case let .iOS(version) = iphone.os,
                        version == "16.0"
                    {
                        return true
                    } else {
                        return false
                    }
                },
                successMessage: "iphone updated sucessfully",
                failureMessage: "iphone did NOT update. It's OS is: \(iphone.os), but must be .iOS(version: \"16.0\")"
            ),
            TestCase(
                testFuntction: {
                    return iphone.call() == "Привет, я new name iOS(version: \"16.0\")"
                },
                successMessage: "iphone is calling successfully",
                failureMessage: "iphone is NOT calling succesfully. It's result is \(iphone.call())"
            ),
            TestCase(
                testFuntction: {
                    samsung.rename(newName: "new name")
                    return iphone.name == "new name" },
                successMessage: "property `name` of samsung has correct value after calling rename(:)",
                failureMessage: "property `name` of samsung has  INCORRECT value after calling rename(:). It's value is \(iphone.name)"
            ),
            TestCase(
                testFuntction: { 
                    samsung.update(newOS: OS.android(version: "12.0"))
                    if
                        case let .android(version) = samsung.os,
                        version == "12.0"
                    {
                        return true
                    } else {
                        return false
                    }
                },
                successMessage: "samsung updated sucessfully",
                failureMessage: "samsung did NOT update. It's OS is: \(samsung.os)"
            ),
            TestCase(
                testFuntction: { samsung.call() == "Привет, я new name 7.0" },
                successMessage: "samsung is calling successFully",
                failureMessage: "samsung is NOT calling succesfully. It's result is \(samsung.call())"
            ),
        ]
    }
}
