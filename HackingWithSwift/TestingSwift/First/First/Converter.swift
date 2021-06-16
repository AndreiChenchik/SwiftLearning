//
//  Converter.swift
//  First
//
//  Created by Andrei Chenchik on 16/6/21.
//

import Foundation


struct Converter {
    func convertToCelsius(fahrenheit: Double) -> Double {
        let fahrenheit = Measurement(value: fahrenheit, unit: UnitTemperature.fahrenheit)
        
        let celsius = fahrenheit.converted(to: .celsius)
        
        return celsius.value
    }
}
