//
//  ViewController.swift
//  Project7
//
//  Created by Andrei Chenchik on 26/5/21.
//

import UIKit

class ViewController: UITableViewController {
    let reusableCellId = "reusableCell"
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Simple Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(resetButtonTapped))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellId, for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    @objc func resetButtonTapped() {
        let ac = UIAlertController(title: "Are you sure", message: "Do you want to delete the whole list?", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive) {
            [weak self] _ in
            
            self?.shoppingList.removeAll()
            self?.tableView.reloadData()
        })
        
        present(ac, animated: true)
    }
    
    @objc func addButtonTapped() {
        let ac = UIAlertController(title: "What to add?", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            
            if let itemToAdd = ac?.textFields?[0].text {
                self?.addToList(item: itemToAdd)
            }
        })
        
        present(ac, animated: true)
    }

    func addToList(item: String) {
        shoppingList.append(item)
        let indexPath = IndexPath(row: shoppingList.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

}

