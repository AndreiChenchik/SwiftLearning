import Foundation

// MARK: - ℹ️ Протокол решения
// - Здесь описан протокол с требованиями к решению
// - ⚠️ Не меняйте этот код

public enum OS {
    case iOS(version: String)
    case android(version: String)
}

public protocol SolutionProtocol {
    var diagonal: Double { get }
    var os: OS { get set  }
    var name: String { get set }

    func call() -> String
    func rename(newName: String)
    func update(newOS: OS)
}
