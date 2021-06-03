//
//  GameScene.swift
//  Milestone Project 16-18
//
//  Created by Andrei Chenchik on 2/6/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var difficulty = 1.0
    
    var soldiers = [SKSpriteNode]()
    var civilians = [SKSpriteNode]()
    
    var scoreLabel: SKLabelNode!
    var penalty = 0 {
        didSet {
            scoreLabel.text = "Score: \(score - penalty)"
        }
    }
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score - penalty)"
        }
    }
    
    var gameTimer: Timer?
    var gameOverTimer: Timer?
    let rows = [100, 300, 600]
    
    var isGameOver = false
    
    let soldierImages = ["soldier1", "soldier2", "soldier3", "soldier4", ]
    let civilianImages = ["civilian1", "civilian2", "civilian3", "civilian4", "civilian5", "civilian6", "civilian7", ]
    
    fileprivate func startGameTimer() {
        if gameTimer != nil { gameTimer?.invalidate() }
        let interval = 3.0
        gameTimer = Timer.scheduledTimer(timeInterval: interval / difficulty, target: self, selector: #selector(addTarget), userInfo: nil, repeats: true)
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: 1024, height: 768)
        background.position = CGPoint(x: 512, y: 384)
        
        addChild(background)
        background.zPosition = -1
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = .zero
        
        startGameTimer()
        gameOverTimer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(finishGame), userInfo: nil, repeats: false)
        
    }
    
    @objc func addTarget() {
        var image: String
        let isEnemy = Bool.random()
        
        if isEnemy {
            image = soldierImages.randomElement()!
        } else {
            image = civilianImages.randomElement()!
        }
    
        
        let target = SKSpriteNode(imageNamed: image)
        target.position = CGPoint(x: 1200, y: Int.random(in: 100...600))
        
        let height = CGFloat.random(in: 100...250)
        let aspectRatio = height / target.size.height
        let width = target.size.width * aspectRatio
        
        target.size = CGSize(width: width, height: height)
        
        
        target.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        
        let minSpeed = 100.0 * difficulty
        let maxSpeed = 300.0 * difficulty
        
        target.physicsBody?.velocity = CGVector(dx: -Double.random(in: minSpeed...maxSpeed), dy: 0.0)
        target.physicsBody?.collisionBitMask = .zero
        target.physicsBody?.linearDamping = 0
        addChild(target)
        
        if isEnemy {
            soldiers.append(target)
        } else {
            civilians.append(target)
        }
    }
    
    @objc func finishGame() {
        isGameOver = true
        gameTimer?.invalidate()
        displayScore()
    }
    
    func displayScore() {
        let background = SKShapeNode(rect: CGRect(x: -10, y: -10, width: 1040, height: 1000))
        background.fillColor = .black
        addChild(background)
        background.zPosition = 1
        
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 36
        scoreLabel.position = CGPoint(x: 512, y: 384)
        scoreLabel.text = "Final score: \(score-penalty)"
        addChild(scoreLabel)
        
        scoreLabel.zPosition = 1
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameOver { return }
        guard let touch = touches.first  else { return }
        let location = touch.location(in: self)
        
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            guard let node = node as? SKSpriteNode else { continue }
            if let index = soldiers.firstIndex(of: node) {
                score += 1
                soldiers.remove(at: index)
                node.removeFromParent()
            } else if let index = civilians.firstIndex(of: node) {
                penalty += 5
                civilians.remove(at: index)
                node.removeFromParent()
            }
            
        }
        

        if score % 10 == 0 {
            difficulty *= 1.2
            startGameTimer()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if isGameOver { return }
        
        for (index, node) in civilians.enumerated() {
            if node.position.x < -100 {
                node.removeFromParent()
                civilians.remove(at: index)
            }
        }
        for (index, node) in soldiers.enumerated() {
            if node.position.x < -100 {
                node.removeFromParent()
                soldiers.remove(at: index)
                penalty += 2
            }
        }
    }
}
