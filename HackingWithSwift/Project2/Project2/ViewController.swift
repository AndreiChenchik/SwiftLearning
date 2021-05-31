//
//  ViewController.swift
//  Project2
//
//  Created by Andrei Chenchik on 22/5/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var attempt = 0
    var maxAttempts = 10
    var highScore = 0
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highScore = defaults.integer(forKey: "highScore")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chart.bar.fill"), style: .plain, target: self, action: #selector(showScore))
        
        countries += ["estonia", "france", "germany", "italy", "ireland", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        let borderWidth: CGFloat = 1
        let borderColor = UIColor.lightGray.cgColor
        
        button1.layer.borderWidth = borderWidth
        button2.layer.borderWidth = borderWidth
        button3.layer.borderWidth = borderWidth
        
        button1.layer.borderColor = borderColor
        button2.layer.borderColor = borderColor
        button3.layer.borderColor = borderColor
        
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        let question = countries[correctAnswer].uppercased()
        title = "Guess the FLAG of \(question)"
    }

    func displayAlert(title: String, message: String, action: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action, style: .default, handler: { _ in self.askQuestion() }))
        present(ac, animated: true)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let selectedCountry = countries[sender.tag].uppercased()
        
        attempt += 1
 
        
        if sender.tag == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
        
        if attempt == maxAttempts {
            if score > highScore {
                displayAlert(title: "Game ended", message: "You scored \(score) in \(attempt) attempts.\n And set a new high score! 🥳", action: "Start over")
                highScore = score
                defaults.set(highScore, forKey: "highScore")
            } else {
                displayAlert(title: "Game ended", message: "You scored \(score) in \(attempt) attempts 🥳\n Current high score is \(highScore)", action: "Start over")
            }
            score = 0
            attempt = 0
        } else if sender.tag != correctAnswer {
            displayAlert(title: "Wrong answer", message: "You tapped \(selectedCountry) 🙃", action: "Try again")
        } else {
            askQuestion()
        }
        

    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Score board", message: "Your score is \(score).\nCurrent high score is \(highScore).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
}

