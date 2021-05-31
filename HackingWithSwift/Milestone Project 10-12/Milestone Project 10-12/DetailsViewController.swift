//
//  DetailsViewController.swift
//  Milestone Project 10-12
//
//  Created by Andrei Chenchik on 31/5/21.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var imageName: String!
    var imagePath: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = imageName
        imageView.image = UIImage(contentsOfFile: imagePath)
        navigationItem.largeTitleDisplayMode = .never
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
