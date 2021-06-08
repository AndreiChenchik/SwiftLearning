//
//  ListTableViewController.swift
//  Project4
//
//  Created by Andrei Chenchik on 25/5/21.
//

import UIKit

class ListTableViewController: UITableViewController {
    let websites = ["chenchik.me", "apple.com", "hackingwithswift.com"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Easy Browser"
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = websites[indexPath.row]
        
        return cell
    }

    // MARK: - Table delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "webView") as? ViewController else { return }
        
        vc.websites = websites
        vc.selectedWebsite = websites[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }


}
