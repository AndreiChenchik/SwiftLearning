//
//  ViewController.swift
//  Milestone Project 7-9
//
//  Created by Andrei Chenchik on 27/5/21.
//

import UIKit

class ViewController: UIViewController {
    var keyWord: String?
    var goodAttempts = [String]()
    var failedAttempts = [String]()
    var words: [String]?
    var scoresLabel: UILabel!

    let minWordLength = 7
    var lives = 7 {
        didSet {
            DispatchQueue.main.async {
                [weak self] in
                if let lives = self?.lives {
                    self?.scoresLabel.text = " Lives: \(lives) ❤️"
                }
            }
        }
    }
    let alphabet = (97...122).map {String(UnicodeScalar($0))}

    var textField: UITextField!
    var textFieldKeyboardConstraint: NSLayoutConstraint!
    var logoLabelKeyboardConstraint: NSLayoutConstraint!

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func loadView() {
        view = UIView()

        // MARK: - Background View
        let gradientStartColor = hexStringToUIColor(hex: "#022e57")
        let gradientEndColor = hexStringToUIColor(hex: "#005a8d")

        let backgroundView = GradientView(gradientStartColor: gradientStartColor, gradientEndColor: gradientEndColor)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(backgroundView)

        // MARK: - Logo Label
        let logoLabel = UILabel()
        logoLabel.translatesAutoresizingMaskIntoConstraints = false

        let logoLabelColor = hexStringToUIColor(hex: "#fff5fd")
        logoLabel.textColor = logoLabelColor
        logoLabel.textAlignment = .center
        logoLabel.font = UIFont.systemFont(ofSize: 24)
        logoLabel.text = "Hangman Game"

        view.addSubview(logoLabel)

        // MARK: - Text Field
        textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false

        let textFieldColor = hexStringToUIColor(hex: "#fff5fd")
        textField.textColor = textFieldColor
        textField.textAlignment = .center
        textField.autocorrectionType = .no
        textField.tintColor = .clear
        textField.font = UIFont.systemFont(ofSize: 36)
        textField.keyboardType = .alphabet

        view.addSubview(textField)

        // MARK: - Scores Label
        scoresLabel = UILabel()
        scoresLabel.translatesAutoresizingMaskIntoConstraints = false

        let scoresLabelColor = hexStringToUIColor(hex: "#fff5fd")
        scoresLabel.textColor = scoresLabelColor
        scoresLabel.textAlignment = .right
        scoresLabel.font = UIFont.systemFont(ofSize: 16)
        scoresLabel.layer.cornerRadius = 5

        view.addSubview(scoresLabel)

        // MARK: - Constraints
        textFieldKeyboardConstraint = textField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)

        NSLayoutConstraint.activate([

            // MARK: For Background View
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // MARK: For Text View
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldKeyboardConstraint,

            // MARK: For Logo Label
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoLabel.bottomAnchor.constraint(equalTo: textField.topAnchor),

            // MARK: For Scores Label
            scoresLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            scoresLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)

        textField.becomeFirstResponder()
        textField.delegate = self

        performSelector(inBackground: #selector(startGame), with: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func startGame() {
        goodAttempts = []
        failedAttempts = []

        loadWords()

        words!.shuffle()

        for word in words! {
            if word.count >= minWordLength && !word.contains("-") {
                keyWord = word.uppercased()
                break
            }
        }

        lives = keyWord!.count

        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }

            self.textField.text = String(repeating: "?", count: self.keyWord!.count)
            self.textField.becomeFirstResponder()
        }
    }

    private func loadWords() {
        do {
            if let path = Bundle.main.path(forResource: "3000words", ofType: "txt") {
                let fileString = try String(contentsOfFile: path)
                words = fileString.components(separatedBy: "\n")
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    @objc private func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardPosition = keyboardFrame.origin.y

            if keyboardPosition >= UIScreen.main.bounds.size.height {
                self.textFieldKeyboardConstraint.constant = 0.0
            } else {
                self.textFieldKeyboardConstraint.constant = keyboardFrame.size.height * -0.35
            }
        }

        UIView.animate(
            withDuration: 0.2,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }

    @objc private func buttonTapped(sender: UIButton) {
        sender.isHidden = true
    }

    private func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func doNextMove(with characterString: String) {
        let userChar = characterString.uppercased()

        if goodAttempts.contains(userChar) || failedAttempts.contains(userChar) {
            return
        }

        guard let keyWord = keyWord else { fatalError("Don't have any words to guess") }

        if keyWord.contains(userChar) {
            goodAttempts.append(userChar)

            var userWord = ""

            for char in keyWord {
                let letter = String(char)

                if letter == userChar || goodAttempts.contains(letter) {
                    userWord += letter
                } else {
                    userWord += "?"
                }
            }
            textField.text = userWord
            if !userWord.contains("?") {
                missionAccomplished()
            }
        } else {
            lives -= 1

            failedAttempts.append(userChar)

            UIView.transition(with: scoresLabel, duration: 0.5, options: .transitionCrossDissolve) {
                self.scoresLabel.backgroundColor = self.hexStringToUIColor(hex: "#ff96ad")
            } completion: { _ in
                UIView.transition(with: self.scoresLabel, duration: 0.5, options: .transitionCrossDissolve) {
                    self.scoresLabel.backgroundColor = .clear
                }
            }

            if lives == 0 {
                gameOver()
            }
        }

    }

    func gameOver() {
        let ac = UIAlertController(title: "YOU DIED", message: "It was \(keyWord!) 😵\nWant to try again?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak self] _ in
            self?.startGame()
        })

        present(ac, animated: true)
    }

    func missionAccomplished() {
        let ac = UIAlertController(title: "Well done!", message: "It was \(keyWord!) 🕵️\nWant to play again?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Sure", style: .default) {
            [weak self] _ in
            self?.startGame()
        })

        present(ac, animated: true)
    }

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if keyWord != nil {
            return true
        }
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterString = string.lowercased()
        if alphabet.contains(characterString) {
            doNextMove(with: characterString)
        }

        return false
    }
}
