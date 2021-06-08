//
//  ViewController.swift
//  Project1
//
//  Created by Andrei Chenchik on 21/5/21.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    
    
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
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pictures.count)
        return pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath)
                as? PictureCollectionViewCell else { fatalError("Can't find cell") }
        
        cell.title.text = pictures[indexPath.row]
        cell.imageView.image = UIImage(named: pictures[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let selectedRow = indexPath.row
            
            vc.selectedImage = pictures[selectedRow]
            vc.selectedImageNumber = selectedRow + 1
            vc.totalImages = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let appRecommendation = "Storm Viewer App - safe place to watch the most dangerous storms on U.S. soil!"
        
        let vc = UIActivityViewController(activityItems: [appRecommendation], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

