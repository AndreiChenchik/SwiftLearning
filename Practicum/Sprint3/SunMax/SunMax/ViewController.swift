//
//  ViewController.swift
//  SunMax
//
//  Created by Andrei Chenchik on 18/7/22.
//

import UIKit

class ViewController: UIViewController {
    var isSun = false
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var skyImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        skyImageView.image = UIImage(systemName: "moon")
        skyImageView.tintColor = .gray
        
        changeButton.tintColor = .systemGreen
    }
    
    @IBAction func buttonDidTap(_ sender: Any) {
        skyImageView.image = isSun ? UIImage(systemName: "sun.max") : UIImage(systemName: "moon")
        isSun.toggle()
    }
    
    @IBAction func buttonDown(_ sender: Any) {
        print("Button is down!")
    }
}

