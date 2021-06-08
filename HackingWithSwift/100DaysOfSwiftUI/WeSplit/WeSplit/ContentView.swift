//
//  ContentView.swift
//  WeSplit
//
//  Created by Andrei Chenchik on 8/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let numberFormatter = NumberFormatter()
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        numberFormatter.locale = Locale.current
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(truncating: numberFormatter.number(from: checkAmount) ?? 0)
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        numberFormatter.locale = Locale.current
        let peopleCount = Double(truncating: numberFormatter.number(from: numberOfPeople) ?? 1)
        let amoutPerPerson = grandTotal / peopleCount
        
        return amoutPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Grand total")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
