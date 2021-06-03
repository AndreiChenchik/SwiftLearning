//
//  NoteViewController.swift
//  Milestone Project 19-21
//
//  Created by Andrei Chenchik on 3/6/21.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var textView: UITextView!
    var note: Note!
    var table: ViewController!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        title = note.title
        textView.text = note.body
        
        textView.delegate = self
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteNote)),
            UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareNote))
        ]
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndframe = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndframe, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textView.scrollIndicatorInsets = textView.contentInset
        
        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
    
    @objc func shareNote() {
        guard let text = note.body else { return }
        
        let shareController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        shareController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems?[1]
        present(shareController, animated: true)
    }
    
    @objc func deleteNote() {
        let deleteAC = UIAlertController(title: "Are you sure?", message: "Please confirm the removal of current note", preferredStyle: .alert)
        deleteAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        deleteAC.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            self.table.deleteNote(at: self.indexPath)
            self.navigationController?.popViewController(animated: true)
        }))
        
        
        present(deleteAC, animated: true)
    }

    
    func textViewDidChange(_ textView: UITextView) {
        note.body = textView.text
        updateNote()
    }
    
    func updateNote() {
        table.updateNote(at: indexPath, with: note)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
