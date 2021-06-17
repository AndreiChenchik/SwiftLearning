//
//  ContentView.swift
//  MultiTable
//
//  Created by Andrei Chenchik on 17/6/21.
//

import SwiftUI

struct QuestionStatusView: View {
    @StateObject var question: Question
    
    var body: some View {
        if let userAnswer = question.userAnswer {
            if userAnswer == question.rightAnswer {
                return Image(systemName: "checkmark.seal.fill").foregroundColor(.green)
            } else {
                return Image(systemName: "xmark").foregroundColor(.red)
            }
        } else {
            return Image(systemName: "questionmark").foregroundColor(.blue)
        }
    }
}

struct QuestionView: View {
    @StateObject var question: Question
    
    var body: some View {
        HStack {
            Text("\(question.description)")
            Text("=")
            Text("\(question.userAnswerDescription)")
            
            Spacer()
            
            QuestionStatusView(question: question)
        }
    }
}

struct TableView: View {
    @StateObject var table: Table
    
    @State private var alertQuestion: Question? = nil
    @State private var isAlertShowing = false
    
    var body: some View {
        
        List {
            ForEach(table.questions) { question in
                Button(action: {
                    if question.userAnswer == nil {
                        self.alertQuestion = question
                        self.isAlertShowing = true
                    }
                }, label: {
                    QuestionView(question: question)
                })
            }
        }
        .alert(isPresented: $isAlertShowing, TextAlert(title: self.alertQuestion?.description ?? "", message: "How much will it be?", keyboardType: .numberPad) { result in
            guard let text = result else { return }
            guard let question = alertQuestion else { fatalError("No question provided") }
            guard let userNumber = Int(text) else {
                self.isAlertShowing = true
                return
            }
            
            question.userAnswer = userNumber
        })
        .navigationTitle("MultiTable")
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(table: Table(lowerBound: 1, upperBound: 12))
    }
}
