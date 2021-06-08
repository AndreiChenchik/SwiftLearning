//
//  ViewController.swift
//  Milestone Project 28-30
//
//  Created by Andrei Chenchik on 7/6/21.
//

import UIKit

class ViewController: UIViewController {
    var views = [UIButton]()
    @IBOutlet var pairsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let grid = 4
        let side = (pairsView.frame.size.height - CGFloat(grid + 1)) / CGFloat(grid)
        let spacing = 1
        
        for row in 0..<grid {
            for column in 0..<grid {
                let x = CGFloat((1 + row) * spacing) + side * CGFloat(row)
                let y = CGFloat((1 + column) * spacing) + side * CGFloat(column)
                let tileView = UIButton(frame: CGRect(x: x, y: y, width: side, height: side))
                tileView.addTarget(self, action: #selector(tileTapped), for: .touchUpInside)
                tileView.backgroundColor = .white
                pairsView.addSubview(tileView)
            }
        }
    }

    @objc func tileTapped(_ sender: UIButton) {
        UIView.transition(with: sender, duration: 0.4, options: .transitionFlipFromRight) {
            sender.backgroundColor = .red
        }
    }
}

