//
//  CountriesTableViewController.swift
//  Milestone Project 13-15
//
//  Created by Andrei Chenchik on 1/6/21.
//

import UIKit

class CountriesTableViewController: UITableViewController {
    var countries = [Country]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Loading..."
        
        loadCountries()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadCountries), for: .valueChanged)
    }
    
    @objc func loadCountries() {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: K.wikiURL) else { fatalError("Something wrong with URL") }
            
            do {
                let data = try Data(contentsOf: url)
                
                let wikiData = try JSONDecoder().decode(WikiQuery.self, from: data)
                self.countries = wikiData.results.bindings
                self.countries = self.countries.filter { $0.countryLabel != nil && $0.populationNumber != nil && $0.fertilityRate != nil && $0.lifeExpectancy != nil }
                
                var countriesTemp = [String?: Country]()
                for country in self.countries {
                    if !countriesTemp.keys.contains(country.name) {
                        countriesTemp[country.name] = country
                    }
                }
                
                self.countries.removeAll()
                for countries in countriesTemp {
                    self.countries.append(countries.value)
                }
                
                self.countries.sort { $0.populationNumber! >= $1.populationNumber! }
                
                DispatchQueue.main.async {
                    [weak self] in
                    
                    guard let self = self else { return }
                    
                    self.tableView.reloadSections(IndexSet(0..<1), with: .automatic)
                    self.title = "World Countries"

                    self.tableView.refreshControl?.endRefreshing()
                }
                
            } catch {
                self.errorLoadingData(error)
            }
        }
    }
    
    func errorLoadingData(_ error: Error) {
        let errorAC = UIAlertController(title: "Error Loading data", message: error.localizedDescription, preferredStyle: .alert)
        errorAC.addAction(UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
            self?.loadCountries()
        })
        
        present(errorAC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: K.detailsController) as? DetailsTableViewController else { fatalError("Can't instantiate details View Controller") }
        
        let country = countries[indexPath.row]
        
        vc.country = country
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.countryCell, for: indexPath)
        
        let country = countries[indexPath.row]
        
        cell.textLabel?.text = country.name
        
        return cell
    }
    
}
