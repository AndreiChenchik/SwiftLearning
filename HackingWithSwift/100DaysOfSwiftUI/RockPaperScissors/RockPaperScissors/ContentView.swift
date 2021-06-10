//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andrei Chenchik on 10/6/21.
//

import SwiftUI

struct ContentView: View {
    let strategies = ["Win", "Lose"]
    let options = ["Rock", "Paper", "Scissors"]
    let rules = ["Rock": "Paper", "Paper": "Scissors", "Scissors": "Rock"]
    
    @State private var randomElement = Int.random(in: 0..<3)
    @State private var randomStrategy = Int.random(in: 0..<2)
    @State private var showingWinAlert = false
    
    @State private var score = 0
    @State private var gameStart = Date()
    @State private var gameDuration = 0
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                                        Color(red: 0.54, green: 0.14, blue: 0.53),
                                        Color(red: 0.91, green: 0.25, blue: 0.34),
                                        Color(red: 0.95, green: 0.44, blue: 0.13)]),
                    startPoint: .top,
                    endPoint: .bottom)
                        .ignoresSafeArea()
                VStack {
                    Spacer()
                    Text("\(strategies[randomStrategy]) against \(options[randomElement])")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                    VStack(spacing: 20) {
                        ForEach(0 ..< options.count) { number in
                            Button(action: {
                                self.guessTheAnswer(with: number)
                            }) {
                                Text(options[number])
                                    .frame(minWidth: 200, maxHeight: 50)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    Spacer()
                    Text("Your score: \(score)")
                }
            }
            .navigationTitle("RocPapScis")
        }
        .alert(isPresented: $showingWinAlert, content: {
            Alert(
                title: Text("You win"),
                message: Text("Nicely done in just \(gameDuration) seconds!"),
                dismissButton: .default(Text("Go again")) {
                    gameStart = Date()
                    score = 0
                }
            )
        })
    }
    
    func guessTheAnswer(with number: Int) {
        let win: Bool
        
        if randomStrategy == 0 {
            win = options[number] == rules[options[randomElement]]!
        } else {
            win = options[randomElement] == rules[options[number]]!
        }
        
        if win {
            score += 1
        } else {
            score -= 1
        }
        
        if score >= 10 {
            let gameEnd = Date()
            let timeDiff = Calendar.current.dateComponents([.second], from: gameStart, to: gameEnd)
            gameDuration = timeDiff.second!
            showingWinAlert = true
        }
        let prevElement = randomElement
        let prevStrategy = randomStrategy
        
        while randomStrategy == prevStrategy && randomElement == prevElement {
            randomElement = Int.random(in: 0..<3)
            randomStrategy = Int.random(in: 0..<2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
