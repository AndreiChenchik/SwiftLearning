//: [Previous](@previous)

import Foundation

func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}


enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}


func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: .cloud)

//: [Next](@next)
