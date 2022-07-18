import Foundation

// MARK: - ℹ️ Протокол решения
// - Здесь описан протокол с требованиями к решению
// - ⚠️ Не меняйте этот код

public protocol SolutionProtocol {
    var id: String? { get set }

    func save(id: String?)
}
