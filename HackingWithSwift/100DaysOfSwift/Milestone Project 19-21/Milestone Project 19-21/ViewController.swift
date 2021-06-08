//
//  ViewController.swift
//  Milestone Project 19-21
//
//  Created by Andrei Chenchik on 3/6/21.
//

import UIKit

class ViewController: UITableViewController {
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        title = "My notes"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newNote))
        
        loadData()
    }
    
    func deleteNote(at indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        tableView.reloadSections([0], with: .automatic)
        saveData()
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "notes") as? Data {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([Note].self, from: savedData) {
                notes = loadedNotes
                tableView.reloadSections([0], with: .automatic)
            } else {
                fatalError("Can't decode data")
            }
        }
    }
    
    func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "notes")
        } else {
            fatalError("Can't encode data")
        }
    }
    
    func updateNote(at indexPath: IndexPath, with note: Note) {
        notes[indexPath.row] = note
        saveData()
    }
    
    @objc func newNote() {
        let newNoteAC = UIAlertController(title: "Set title", message: nil, preferredStyle: .alert)
        newNoteAC.addTextField()
        
        let createNote: (UIAlertAction) -> Void = { [weak self, weak newNoteAC] _ in
            guard let self = self else { return }
            if let title = newNoteAC?.textFields?[0].text {
                let note = Note(title: title)
                self.notes.append(note)
                
                let newIndex = IndexPath(row: self.notes.count - 1, section: 0)
                
                self.tableView.insertRows(at: [newIndex], with: .automatic)
            }
            self.saveData()
        }
        
        newNoteAC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        newNoteAC.addAction(UIAlertAction(title: "Create", style: .default, handler: createNote))
        
        present(newNoteAC, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCell, for: indexPath)
        
        let note = notes[indexPath.row]
        
        cell.textLabel?.text = note.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notesVC = storyboard?.instantiateViewController(identifier: K.noteController) as! NoteViewController
        
        notesVC.note = notes[indexPath.row]
        notesVC.table = self
        notesVC.indexPath = indexPath
        
        navigationController?.pushViewController(notesVC, animated: true)
    }
}

