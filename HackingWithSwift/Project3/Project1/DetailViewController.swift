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
        guard let imageFromView = imageView.image else {
            print("No image found")
            return
        }
        
        let image = addCopyright(to: imageFromView)
        
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        guard let imageName = selectedImage else {
            print("Can't load image name")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [imageData, imageName], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func addCopyright(to image: UIImage) -> UIImage {
        let width = image.size.width
        let height = image.size.height
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let finalImage = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
        
            let string = "From Storm Viewer"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
    
            attributedString.draw(with: CGRect(x: 32, y: 32, width: width - 32, height: height - 32), options: .usesLineFragmentOrigin, context: nil)
            
            
        }
        
        return finalImage
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
