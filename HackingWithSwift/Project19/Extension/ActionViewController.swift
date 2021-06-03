//
//  ActionViewController.swift
//  Extension
//
//  Created by Andrei Chenchik on 3/6/21.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    @IBOutlet var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    var pageHost = ""
    
    let scriptExamples = [
        "Print page title": """
            alert(document.title);
            """,
        "Make page Grayscale": """
            document.body.style.filter = 'grayscale(100%)';
            """
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.rightBarButtonItems = [
            //UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel)),
            UIBarButtonItem(image: UIImage(systemName: "play"), style: .plain, target: self, action: #selector(done))
            ]
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "archivebox"), style: .plain, target: self, action: #selector(loadScript)),
            UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveScript))
            ]
        
        let notificationCenter = NotificationCenter.default
        let defaults = UserDefaults.standard
        
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] dict, error in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    guard let self = self else { return }
                    
                    self.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    if let url = URL(string: self.pageURL), let urlHost = url.host {
                        self.pageHost = urlHost
                    } else {
                        self.pageHost = "unknown"
                    }
                    
                    DispatchQueue.main.async {
                        self.script.text = defaults.string(forKey: "for \(self.pageHost)")
                        self.title = self.pageTitle
                    }
                }
            }
        }
    }
    
    @objc func cancel() {
        self.dismiss(animated: true)
    }
    
    @objc func saveScript() {
        let saveAC = UIAlertController(title: "Enter a name for the script", message: nil, preferredStyle: .alert)
        saveAC.addTextField()
        saveAC.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            guard let scriptName = saveAC.textFields?[0].text else { fatalError("TextField missing") }
            guard let self = self else { return }
            
            let defaults = UserDefaults.standard
            var userScripts = defaults.dictionary(forKey: "userScripts") as? [String: String] ?? [String: String]()
            
            userScripts[scriptName] = self.script.text
            defaults.set(userScripts, forKey: "userScripts")
        }))
        saveAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(saveAC, animated: true)
    }
    
    @objc func loadScript() {
        let scriptsAC = UIAlertController(title: "Load script", message: nil, preferredStyle: .actionSheet)
        for script in scriptExamples {
            scriptsAC.addAction(UIAlertAction(title: "Example: \(script.key)", style: .default, handler: { [weak self] _ in self?.script.text = script.value }))
        }
        
        let defaults = UserDefaults.standard
        if let userScripts = defaults.dictionary(forKey: "userScripts") as? [String: String] {
            for script in userScripts {
                scriptsAC.addAction(UIAlertAction(title: script.key, style: .default, handler: { [weak self] _ in self?.script.text = script.value }))
            }
        }
        
        scriptsAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(scriptsAC, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndframe = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndframe, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
        
    }

    @IBAction func done() {
        let defaults = UserDefaults.standard
        defaults.set(script.text, forKey: "for \(self.pageHost)")
        
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScipt = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        
        item.attachments = [customJavaScipt]
        
        extensionContext?.completeRequest(returningItems: [item])
    }

}
