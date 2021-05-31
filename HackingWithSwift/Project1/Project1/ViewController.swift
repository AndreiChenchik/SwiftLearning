//
//  ViewController.swift
//  Project1
//
//  Created by Andrei Chenchik on 21/5/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var views = [String: Int]()
    let defaults = UserDefaults.standard
    
    @objc private func loadPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        views = defaults.object(forKey: "views") as? [String: Int] ?? [String: Int]()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Picture") else { fatalError("Can't find cell") }
        
        let picture = pictures[indexPath.row]
        let views = views[picture, default: 0]
        
        cell.textLabel?.text = picture
        cell.detailTextLabel?.text = "\(views) views"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let selectedRow = indexPath.row
            
            vc.selectedImage = pictures[selectedRow]
            vc.selectedImageNumber = selectedRow + 1
            vc.totalImages = pictures.count
            vc.parentIndexPath = indexPath
            vc.parentController = self
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let appRecommendation = "Storm Viewer App - safe place to watch the most dangerous storms on U.S. soil!"
        
        let vc = UIActivityViewController(activityItems: [appRecommendation], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func updateCell(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}

