//
//  ViewController.swift
//  Project28
//
//  Created by Andrei Chenchik on 7/6/21.
//
import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    var doneButton: UIBarButtonItem!
    
    @IBOutlet var secret: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage))
        
        
        // Do any additional setup after loading the view.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    
    
    @IBAction func authenticateTapped(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            if KeychainWrapper.standard.string(forKey: "Password") != nil {
                checkPassword()
            } else {
                let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication; Do you want to use a password instead?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                ac.addAction(UIAlertAction(title: "Create password", style: .default, handler: createPassword))
                present(ac, animated: true)
            }
        }
        
        
    }
    
    func checkPassword() {
        guard let password = KeychainWrapper.standard.string(forKey: "Password") else { return }
        let ac = UIAlertController(title: "Enter password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Reveal", style: .default, handler: { [weak ac, weak self] _ in
            guard let userPassword = ac?.textFields?[0].text else { return }
            
            if userPassword == password {
                self?.unlockSecretMessage()
            } else {
                self?.wrongPassword()
            }
            
        }))
        present(ac, animated: true)
    }
    
    func wrongPassword() {
        let ac = UIAlertController(title: "Wrong password", message: "You could not be verified; please try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Try again...", style: .default, handler: { [weak self] _ in
            self?.checkPassword()
        }))
        present(ac, animated: true)
    }
    
    func createPassword(_ action: UIAlertAction) {
        let ac = UIAlertController(title: "Create password", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak ac] _ in
            guard let password = ac?.textFields?[0].text else { return }
            guard !password.isEmpty else { return }
            KeychainWrapper.standard.set(password, forKey: "Password")
        }))
        present(ac, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        navigationItem.rightBarButtonItem = doneButton
        title = "Secret stuff!"
        
        if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
            secret.text = text
        }
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        navigationItem.rightBarButtonItem = nil
        title = "Nothing to see here"
    }
    
}

