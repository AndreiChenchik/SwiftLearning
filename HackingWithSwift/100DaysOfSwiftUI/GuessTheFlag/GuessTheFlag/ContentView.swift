//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andrei Chenchik on 9/6/21.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2)
    }
    
    init(_ imageName: String) {
        self.imageName = imageName
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var userScore = 0
    
    @State private var flagRotation: [Double] = [0, 0, 0]
    @State private var flagTransperency: [Double] = [1, 1, 1]
    @State private var flagWrong = [false, false, false]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }, label: {
                        if !self.flagWrong[number] {
                            FlagImage(self.countries[number])
                                .rotation3DEffect(.degrees(flagRotation[number]), axis: (x: 0, y: 1, z: 0))
                                .opacity(self.flagTransperency[number])
                        } else {
                            FlagImage(self.countries[number])
                                .rotation3DEffect(.degrees(flagRotation[number]), axis: (x: 0, y: 1, z: 0))
                                .opacity(self.flagTransperency[number])
                                .colorMultiply(.red)
                        }
                        
                    })
                }
                Spacer()
                Text("Your score is \(userScore)")
                    .foregroundColor(.white)
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue"), action: {
                askQuestion()
            }))
        })
        
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            withAnimation {
                for i in 0...2 {
                    if i == number {
                        self.flagRotation[i] += 360
                    } else {
                        self.flagTransperency[i] = 0.25
                    }
                }
            }
            
            scoreTitle = "Correct"
            scoreMessage = "Well done!"
            userScore += 1
        } else {
            withAnimation {
                self.flagWrong[number] = true
            }
            
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])"
            userScore -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        flagRotation = [0, 0, 0]
        flagTransperency = [1, 1, 1]
        flagWrong = [false, false, false]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
