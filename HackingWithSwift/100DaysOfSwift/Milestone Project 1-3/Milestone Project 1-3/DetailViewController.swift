//
//  DetailViewController.swift
//  Milestone Project 1-3
//
//  Created by Andrei Chenchik on 22/5/21.
//

import UIKit

class DetailViewController: UIViewController {
    var flagImage: String?
    var imageToDisplay: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        guard let flagImage = flagImage else { fatalError("No image to display") }
        imageToDisplay = UIImage(named: flagImage)
        imageView.image = imageToDisplay
        
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        self.navigationItem.rightBarButtonItem = shareBarButton
    }
    
    @objc func shareTapped() {
        guard let imageToShare = imageToDisplay?.jpegData(compressionQuality: 0.8) else { fatalError("Can't load image for sharing") }
        let sharingItems: [Any] = [imageToShare]
        
        let ac = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
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
