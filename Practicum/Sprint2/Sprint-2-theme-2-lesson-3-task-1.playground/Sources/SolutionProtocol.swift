import Foundation

// MARK: - ℹ️ Протокол решения
// - Здесь описан протокол с требованиями к решению
// - ⚠️ Не меняйте этот код

public struct Ship {
    public let name: String?
    public var crew: [String]
}

public protocol SolutionProtocol {
    var starShip: Ship? { get set }

    func getShipName() -> String
    func addCrew(member: String)
    func getFirstCrewMember() -> String
}
