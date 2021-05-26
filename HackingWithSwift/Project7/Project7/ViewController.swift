//
//  ViewController.swift
//  Project7
//
//  Created by Andrei Chenchik on 26/5/21.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions: [Petition] {
        if let filter = filter {
            return petitions.filter { petition in
                return petition.body.contains(filter) || petition.title.contains(filter)
            }
        }
        
        return petitions
    }
    var filter: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        title = "Whitehouse Petitions"
        
        let creditsButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(creditsButtonTapped))
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        
        navigationItem.rightBarButtonItem = searchButton
        navigationItem.leftBarButtonItem = creditsButton
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
        
    }
    
    @objc func creditsButtonTapped() {
        let ac = UIAlertController(title: "Data Source", message: "This data was parsed from public API of WhiteHouse.gov", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func searchButtonTapped() {
        let ac = UIAlertController(title: "Filter the list", message: "Leave field empty to show everything", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Search", style: .default) { [weak ac, weak self] _ in
            if let userFilter = ac?.textFields?[0].text {
                if userFilter != "" {
                    self?.filter = userFilter
                } else {
                    self?.filter = nil
                }
            }
            
            self?.tableView.reloadData()
        })
        present(ac, animated: true)
    }
    
    func showError() {
        let ac  = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        
        cell.textLabel?.text = filteredPetitions[indexPath.row].title
        cell.detailTextLabel?.text = filteredPetitions[indexPath.row].body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

