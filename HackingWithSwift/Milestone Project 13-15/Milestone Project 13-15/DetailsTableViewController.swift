//
//  DetailsTableViewController.swift
//  Milestone Project 13-15
//
//  Created by Andrei Chenchik on 1/6/21.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    var country: Country?
    var countryInfo = [(String, String)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let country = country else { fatalError("Country info is missing") }
        
        title = country.name
        
        countryInfo.append(("Population", "\(country.populationNumber!)"))
        countryInfo.append(("Fertility Rate", "\(country.fertilityRate!)"))
        countryInfo.append(("Life Expectancy", "\(country.lifeExpectancy!)"))
        
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countryInfo.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.detailsItemCell, for: indexPath)
        
        let item = countryInfo[indexPath.row]
        
        cell.textLabel?.text = item.0
        cell.detailTextLabel?.text = item.1
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
