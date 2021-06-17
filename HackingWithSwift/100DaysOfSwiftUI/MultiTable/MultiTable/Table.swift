//
//  Table.swift
//  MultiTable
//
//  Created by Andrei Chenchik on 17/6/21.
//

import Foundation

class Question: Identifiable, ObservableObject {
    let id: UUID
    let description: String
    let rightAnswer: Int
    @Published var userAnswer: Int?
    
    var userAnswerDescription: String {
        if let userAnswer = userAnswer {
            return "\(userAnswer)"
        } else {
            return ""
        }
    }
    
    init(description: String, rightAnswer: Int) {
        self.id = UUID()
        self.description = description
        self.rightAnswer = rightAnswer
        self.userAnswer = nil
    }
    
}

class Table: ObservableObject {
    @Published var questions = [Question]()
    
    init(lowerBound: Int, upperBound: Int, numberOfQuestions: Int? = nil) {
        for number1 in lowerBound ... upperBound {
            for number2 in number1 ... upperBound {
                let description = "\(number1) × \(number2)"
                let answer = number1 * number2
                
                let question = Question(description: description, rightAnswer: answer)
                
                questions.append(question)
            }
        }
        
        questions.shuffle()
        
        if let questionsLimit = numberOfQuestions {
            questions = Array(questions.prefix(questionsLimit - 1))
        }
    }
}
