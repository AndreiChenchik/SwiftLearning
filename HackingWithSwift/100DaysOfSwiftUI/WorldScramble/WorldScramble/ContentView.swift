//
//  ContentView.swift
//  WorldScramble
//
//  Created by Andrei Chenchik on 13/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    private var userScore: Int {
        var counter = 0
        
        for word in usedWords {
            counter += word.count
        }
        
        return counter
    }
    
    var body: some View {
        GeometryReader { fullView in
            NavigationView {
                VStack {
                    TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    List {
                        ForEach(0..<usedWords.count, id: \.self) { index in
                            GeometryReader { wordView in
                                HStack {
                                    Image(systemName: "\(usedWords[index].count).circle")
                                        .foregroundColor(Color(hue: Double(wordView.frame(in: .global).maxY / fullView.frame(in: .global).maxY), saturation: 1, brightness: 1))
                                    Text(usedWords[index])
                                }
                                .offset(x: wordView.frame(in: .global).midY > fullView.frame(in: .global).midY * 1.2 ? 1.5 * (wordView.frame(in: .global).midY - fullView.frame(in: .global).midY * 1.2): 0)
                                .accessibilityElement(children: .ignore)
                                .accessibility(label: Text("\(usedWords[index]), \(usedWords[index].count) letters"))
                            }
                            .frame(height: 20)
                        }
                    }
                    .listStyle(PlainListStyle())
                    Text("User score: \(usedWords.count) words of \(userScore) chars")
                }
                .navigationTitle(rootWord)
                .navigationBarItems(leading: Button(action: {
                    self.startGame()
                }) {
                    Image(systemName: "arrow.clockwise")
                })
                .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isNotStartWord(word: answer) else {
            wordError(title: "It's cheating", message: "Nope, you can't use the start word")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word is not possible", message: "That isn't a real world")
            return
        }
        
        guard isNotShort(word: answer) else {
            wordError(title: "Word is too short", message: "Are you 12 or something?")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkWorm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isNotStartWord(word: String) -> Bool {
        return word != rootWord
    }
    
    func isNotShort(word: String) -> Bool {
        return word.count > 2
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
