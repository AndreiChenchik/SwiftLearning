import Foundation

/// Функция исследования планеты
///
/// Исследует формы жизни на планете и возвращает массив найденных форм жизни
///
func researchPlanet(shipName: String, planetName: String) -> [String] {
    print("⬇️ 🌎 Судно \(shipName) приступило к исследованию планеты \(planetName)")

    var foundSpeciesOnPlanet: [String] = []
    // Исследуем формы жизни и заполняем массив `foundSpecies`...

    print("⏹ 🌎 Судно \(shipName) покидает планету \(planetName)")

    return foundSpeciesOnPlanet
}

/// Функция исследования системы
///
/// Проходится по всем планетам системы,
/// исследует формы жизни на них и возвращает массив найденных форм жизни
///
func researchSystem(shipName: String, systemName: String, systemPlanets: [String]) -> [String] {
    print("⬇️ 🌞 Судно \(shipName) прибыло в систему \(systemName)")
    print("ℹ️ Предстоит изучить \(systemPlanets.count) планет\n")

    var foundSpeciesInSystem: [String] = []
    for planetName in systemPlanets {
        let foundSpeciesOnPlanet = researchPlanet(shipName: shipName, planetName: planetName)
        foundSpeciesInSystem.append(contentsOf: foundSpeciesOnPlanet)
        print("ℹ️ На планете \(planetName) найдено \(foundSpeciesOnPlanet.count) форм жизни\n")
    }

    print("⏹ 🌞 Судно \(shipName) покидает систему \(systemName)")

    return foundSpeciesInSystem
}

/// Главная функция исследования галактики
///
/// Проходится по всем системам и планетам галактики,
/// исследует формы жизни на них и возвращает массив найденных форм жизни
///
func researchGalaxy(
    shipName: String,
    galaxyName: String,
    systemsWithPlanets: [(String, [String])]
) -> [String] {
    print("⬇️ 🌌 Приступаем к изучению галактики \(galaxyName)")
    print("ℹ️ Предстоит изучить \(systemsWithPlanets.count) систем\n")

    var foundSpeciesInGalaxy: [String] = []
    for (systemName, systemPlanets) in systemsWithPlanets {
        let foundsSpeciesInSystem = researchSystem(
            shipName: shipName,
            systemName: systemName,
            systemPlanets: systemPlanets
        )
        foundSpeciesInGalaxy.append(contentsOf: foundsSpeciesInSystem)

        print("ℹ️ В системе \(systemName) найдено \(foundsSpeciesInSystem.count) форм жизни\n")
    }

    print("⏹ 🌌 Исследование галактики \(galaxyName) завершено")

    return foundSpeciesInGalaxy
}

let shipName: String = "Тысячелетний сокол"
let galaxyName: String = "Млечный путь"
let systemsWithPlanets: [(String, [String])] = [
    ("Арканис", ["Татуин"]),
    ("Солнечная система", ["Меркурий", "Венера", "Земля", "Марс"])
]
let foundSpeciesInGalaxy = researchGalaxy(
    shipName: shipName,
    galaxyName: galaxyName,
    systemsWithPlanets: systemsWithPlanets
)
print("ℹ️ Найдено \(foundSpeciesInGalaxy.count) форм жизни")
