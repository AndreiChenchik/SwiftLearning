//
//  SettingsView.swift
//  MultiTable
//
//  Created by Andrei Chenchik on 17/6/21.
//

import SwiftUI

struct SettingsView: View {
    @State private var upperComplexity = 12
    @State private var lowerComplexity = 1
    @State private var numberOfQuestionsSelection = 3
    
    let questions = ["5", "10", "20", "All!"]
    
    var numberOfQuestions: Int? {
        if let number = Int(questions[numberOfQuestionsSelection]) {
            return number
        } else {
            return nil
        }
    }

    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("Complexity")) {
            Stepper("Starting from \(lowerComplexity)", value: $lowerComplexity, in: 1...upperComplexity)
            Stepper("Up to \(upperComplexity)", value: $upperComplexity, in: lowerComplexity...12)
            }
            
            Section(header: Text("Number of questions")) {
                Picker("Number of questions", selection: $numberOfQuestionsSelection) {
                    ForEach(0 ..< questions.count) {
                        Text("\(self.questions[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .id(numberOfQuestionsSelection)
            }

            Section(header: Text("Ready to start?")) {
                
                    NavigationLink(
                        destination: TableView(table: Table(lowerBound: lowerComplexity, upperBound: upperComplexity, numberOfQuestions: numberOfQuestions)),
                        label: {
                            Text("Start the test!")
                        })
            }
        }
        .navigationTitle("Complexity Setting")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
