import Foundation

// MARK: - ℹ️ Протокол решения
// - Здесь описан протокол с требованиями к решению
// - ⚠️ Не меняйте этот код

public protocol SolutionProtocol {
    var name: String { get set }
    var galaxy: String { get set }
    var isPopulated: Bool { get set }
    var description: String { get set }
}
