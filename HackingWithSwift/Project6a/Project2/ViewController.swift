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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if sender.tag == correctAnswer {
            score += 1
            
            if score == 10 {
                displayAlert(title: "Well done!", message: "You scored 10 and won 🥳", action: "Start over")
                score = 0
            } else {
                askQuestion()
            }
        } else {
            score -= 1
            displayAlert(title: "Wrong answer", message: "You tapped \(selectedCountry) 🙃", action: "Try again")
        }
        

    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Score board", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
}

