//
//  DetailViewController.swift
//  Project1
//
//  Created by Andrei Chenchik on 21/5/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var views = [String: Int]()
    
    var selectedImage: String?
    
    var selectedImageNumber: Int?
    var totalImages: Int?
    weak var parentController: ViewController?
    var parentIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(selectedImage != nil, "No image selected!")
        guard let selectedImageNumber = selectedImageNumber, let totalImages = totalImages else { fatalError("Didn't recieve expected parameters of image to activate the view") }
        
        
        let defaults = UserDefaults.standard
        views = defaults.object(forKey: "views") as? [String: Int] ?? [String: Int]()
        
        title = "Picture \(selectedImageNumber) of \(totalImages)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage, let indexPath = parentIndexPath, let parent = parentController {
            imageView.image = UIImage(named: imageToLoad)
            views[imageToLoad, default: 0] += 1
            defaults.set(views, forKey: "views")
            parent.views = views
            parent.updateCell(at: indexPath)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
