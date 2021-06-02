//
//  ViewController.swift
//  Project18
//
//  Created by Andrei Chenchik on 2/6/21.
//

import UIKit

class ViewController: UIViewController {

    fileprivate func basicDebugging() {
        print("I'm inside the viewDidLoad() method!")
        print(1, 2, 3, 4, 5)
        print(1, 2, 3, 4, 5, separator: "-")
        print("Some message", terminator: "! ")
        print("Another message")
        
        
        
        
        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
        
        
        assert(1 == 1, "Maths failure!")
        // assert(1 == 2, "Maths failure!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basicDebugging()

        for i in 1...100 {
            print("Got number \(i).")
        }
        
    }
    
    
    func myReallySlowMethod() -> Bool {
        return true
    }


}

