//
//  GameViewController.swift
//  Project29
//
//  Created by Andrei Chenchik on 7/6/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var currentGame: GameScene?
    
    @IBOutlet var playerNumber: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var windLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                currentGame = scene as? GameScene
                currentGame?.viewController = self
                
                // Present the scene
                view.presentScene(scene)
                

            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        angleSlider.value = 45
        velocitySlider.value = 125
        angleChanged(angleSlider)
        velocityChanged(velocitySlider)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func angleChanged(_ sender: UISlider) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    @IBAction func velocityChanged(_ sender: UISlider) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    @IBAction func launch(_ sender: UIButton) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        velocityLabel.isHidden = true
        velocitySlider.isHidden = true
        launchButton.isHidden = true
        
        currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>>"
        }
        
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        velocityLabel.isHidden = false
        velocitySlider.isHidden = false
        launchButton.isHidden = false
        
    }
}
