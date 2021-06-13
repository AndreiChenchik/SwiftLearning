//
//  ContentView.swift
//  BetterRest
//
//  Created by Andrei Chenchik on 11/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    let model = SleepCalculator()
    var idealBedtime: String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        let wakeUpSeconds = hour + minute
        do {
            let prediction = try model.prediction(wake: Double(wakeUpSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return "Your ideal bedtime is \(formatter.string(from: sleepTime))"
        } catch {
            return "Something went wrong"
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                    
                }
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Picker("Intake", selection: $coffeeAmount) {
                        ForEach(0..<8) {
                            if $0 == 1 {
                                Text("1 cup")
                            } else {
                                Text("\($0) cups")
                            }
                        }
                    }
                    
                }
            }

                Text(idealBedtime)
                    .font(.title2)
                    .padding()
            }
            .navigationTitle("BetterRest")
            .navigationTitle("Test")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
