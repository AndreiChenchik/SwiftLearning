//
//  ViewController.swift
//  Milestone Project 10-12
//
//  Created by Andrei Chenchik on 31/5/21.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        title = "My Photo Library"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPictureTapped))
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    @objc func addPictureTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    private func loadData() {
        let defaults = UserDefaults.standard
        if let picturesData = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: picturesData)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    private func saveData() {
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONEncoder()
        
        guard let picturesData = try? jsonEncoder.encode(pictures) else { fatalError("Can't encode pictures") }
        
        defaults.set(picturesData, forKey: "pictures")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        
        let image = pictures[indexPath.row]
        
        cell.textLabel?.text = image.name

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "detailsController") as? DetailsViewController else { fatalError("Can't instantiate details view controller") }
        
        let image = pictures[indexPath.row]
        
        vc.imageName = image.name
        vc.imagePath = getDocumentsDirectory().appendingPathComponent(image.fileName)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}


extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        
        let renameAC = UIAlertController(title: "Name the photo", message: "How should we call it?", preferredStyle: .alert)
        renameAC.addTextField()
        
        let renameAction = UIAlertAction(title: "Save", style: .default) {
            [weak picker, weak renameAC, weak self] _ in
            
            guard let self = self else { return }
            
            if let name = renameAC?.textFields?[0].text {
                let picture = Picture(name: name, fileName: imageName)
                
                let indexPath = IndexPath(row: self.pictures.count, section: 0)
                self.pictures.append(picture)
                self.saveData()
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
            picker?.dismiss(animated: true)
        }
        
        renameAC.addAction(renameAction)
        
        picker.present(renameAC, animated: true)
    }
}
