//
//  ViewController.swift
//  Project5
//
//  Created by Andrei Chenchik on 25/5/21.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }

        usedWords = defaults.array(forKey: "usedWords") as? [String] ?? [String]()
        title = defaults.object(forKey: "title") as? String ?? allWords.randomElement()
        defaults.set(title, forKey: "title")
    }

    
    @objc func restartGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        
        defaults.set(title, forKey: "title")
        defaults.set(usedWords, forKey: "usedWords")
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    if isNotShort(word: lowerAnswer) {
                        if isNotStartWord(word: lowerAnswer) {
                            usedWords.insert(lowerAnswer, at: 0)
                            defaults.set(usedWords, forKey: "usedWords")

                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                            
                            return
                        } else {
                            errorTitle = "It's cheating!"
                            errorMessage = "You can't use \(title!.lowercased()) here"
                        }
                    } else {
                        errorTitle = "Too short"
                        errorMessage = "Are you 12 or something?"
                    }
                } else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know!"
                }
            } else {
                errorTitle = "Word already used"
                errorMessage = "Be more original!"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title!.lowercased())"
        }
        
        showErrorMessage(title: errorTitle, message: errorMessage)
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isNotStartWord(word: String) -> Bool {
        guard let startWord = title?.lowercased() else { return false }

        return word != startWord
    }
    
    func isNotShort(word: String) -> Bool {
        return word.count > 3
    }
}

