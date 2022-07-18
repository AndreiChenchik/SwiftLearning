import Foundation

// MARK: - ℹ️ Протокол решения
// - Здесь описан протокол с требованиями к решению
// - ⚠️ Не меняйте этот код

public protocol SolutionProtocol {
    var name: String { get set }
    var weight: Int { get set }
    var role: String { get set }
    
    mutating func setRole(_ role: String)
}
