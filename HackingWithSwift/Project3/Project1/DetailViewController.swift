//
//  DetailViewController.swift
//  Project1
//
//  Created by Andrei Chenchik on 21/5/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    var selectedImageNumber: Int?
    var totalImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedImageNumber = selectedImageNumber, let totalImages = totalImages else { fatalError("Didn't recieve expected parameters of image to activate the view") }
        
        title = "Picture \(selectedImageNumber) of \(totalImages)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        guard let imageName = selectedImage else {
            print("Can't load image name")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
