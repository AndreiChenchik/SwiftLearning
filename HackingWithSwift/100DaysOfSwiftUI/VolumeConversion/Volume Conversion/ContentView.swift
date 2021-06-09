//
//  ContentView.swift
//  Volume Conversion
//
//  Created by Andrei Chenchik on 9/6/21.
//

import SwiftUI

struct Unit {
    let name: String
    let shortName: String
    let coeffToMl: Double
}

struct ContentView: View {
    @State private var unitFrom = 0
    @State private var unitTo = 1
    @State private var userAmount = ""
    
    var result: Double {
        numberFormatter.locale = Locale.current
        let amountToConver = Double(truncating: numberFormatter.number(from: userAmount) ?? 0)
        let resultingAmount = amountToConver * units[unitFrom].coeffToMl / units[unitTo].coeffToMl
        
        return resultingAmount
    }
    
    let numberFormatter = NumberFormatter()
    let units = [
        Unit(name: "Milliliters", shortName: "ml", coeffToMl: 1),
        Unit(name: "Liters", shortName: "l", coeffToMl: 1000),
        Unit(name: "US Cups", shortName: "c", coeffToMl: 236.59),
        Unit(name: "US Pints", shortName: "pt", coeffToMl: 473.176),
        Unit(name: "Imperial Pint", shortName: "pt", coeffToMl: 568.261),
        Unit(name: "US Gallons", shortName: "gal", coeffToMl: 3785.41),
        Unit(name: "Imperial Gallon", shortName: "gal", coeffToMl: 4546.09)
    ]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Units")) {
                    Picker("Convert From", selection: $unitFrom) {
                        ForEach(0 ..< units.count) {
                            Text(units[$0].name)
                        }
                    }
                    Picker("Convert To", selection: $unitTo) {
                        ForEach(0 ..< units.count) {
                            Text(units[$0].name)
                        }
                    }
                }
                Section(header: Text("Value")) {
                    TextField("Enter value to convert", text: $userAmount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Result"), footer: Text("Converted from \(units[unitFrom].name) to \(units[unitTo].name)")) {
                    Text("\(result, specifier: "%.2f") \(units[unitTo].shortName)")
                }
            }
            .navigationBarTitle("Volume Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
