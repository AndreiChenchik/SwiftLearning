//
//  ViewController.swift
//  Milestone Project 1-3
//
//  Created by Andrei Chenchik on 22/5/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var flagImages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "World Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let mainBundlePath = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: mainBundlePath)
        
        for item in items {
            if item.hasSuffix(".png") {
                flagImages.append(item)
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        
        let label = flagImages[indexPath.row].dropLast(".png".count).uppercased()
        cell.textLabel?.text = label
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else { fatalError("Can't instantiate VC with \"Detail\" identifier")}
        
        vc.flagImage = flagImages[indexPath.row]
        vc.title = tableView.cellForRow(at: indexPath)?.textLabel?.text
        
        navigationController?.pushViewController(vc, animated: true)
    }


}

