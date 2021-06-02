//
//  GameScene.swift
//  Project17
//
//  Created by Andrei Chenchik on 2/6/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player: Player!
    var scoreLabel: SKLabelNode!
    
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false
    
    var enemiesCount = 0
    var enemyTimer = 1.0
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    fileprivate func setEnemyTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: enemyTimer, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        
        addChild(starfield)
        starfield.zPosition = -1
        
        player = Player(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        
        addChild(scoreLabel)
        
        score = 0
        
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        setEnemyTimer()
    }
    
    @objc func createEnemy() {
        if isGameOver { return }
        
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        
        addChild(sprite)
        enemiesCount += 1
        if enemiesCount % 20 == 0 {
            gameTimer?.invalidate()
            enemyTimer *= 0.8
            setEnemyTimer()
        }
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
        
        if let direction = player.direction {
            let position = player.position
            let distance = sqrt(pow((direction.x - position.x), 2) + pow((direction.y - position.y), 2))
            let multiplier = distance / player.possibleSpeed
            
            if multiplier > 1/60 {
                let dx = (direction.x - position.x) / multiplier
                let dy = (direction.y - position.y) / multiplier
                
                player.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
            } else {
                player.physicsBody?.velocity = .zero
                player.position = direction
            }
        } else {
            player.physicsBody?.velocity = .zero
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.direction = nil
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        //player.position = location
        player.direction = location
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        isGameOver = true
    }
}
