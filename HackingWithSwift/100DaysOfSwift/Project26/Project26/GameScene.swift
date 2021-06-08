//
//  GameScene.swift
//  Project26
//
//  Created by Andrei Chenchik on 5/6/21.
//

import CoreMotion
import SpriteKit
import GameplayKit

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case teleport = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var levels = [String]()
    var currentLevel = 0
    var teleportExit: SKSpriteNode?
    
    var player: SKSpriteNode!
    
    var lastTouchPosition: CGPoint?
  
    var motionManager: CMMotionManager?
    var isGameOver = false
    
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    fileprivate func loadLevelsList() {
        levels.append("level0")
        levels.append("level1")
        levels.append("level3")
    }
    
    fileprivate func drawHUD() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    }
    
    override func didMove(to view: SKView) {
        drawHUD()
        
        loadLevelsList()
        
        loadLevel()
        createPlayer()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    }
    
    fileprivate func addWallBlock(_ position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "block")
        node.position = position
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        node.physicsBody?.isDynamic = false
        addChild(node)
    }
    
    fileprivate func addVortexBlock(_ position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "vortex")
        node.name = "vortex"
        node.position = position
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.frame.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
    }
    
    fileprivate func addStarBlock(_ position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "star")
        node.name = "star"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width/2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    fileprivate func addFinishBlock(_ position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "finish")
        node.name = "finish"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width/2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    func addTeleportBlock(_ position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "teleport")
        node.name = "teleport"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width/2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionTypes.teleport.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    func addTeleportExitBlock(_ position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "teleportExit")
        node.name = "teleportExit"
        node.position = position
        teleportExit = node
        addChild(node)
    }
    
    
    func loadLevel() {
        guard let levelURL = Bundle.main.url(forResource: levels[currentLevel], withExtension: "txt") else { fatalError("Can't find level file in main bundle") }
        guard var levelString = try? String(contentsOf: levelURL) else { fatalError("Can't load level data") }
        
        if levelString.hasSuffix("\n") { levelString = String(levelString.dropLast(1)) }
        
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                switch letter {
                case "x":
                    addWallBlock(position)
                case "v":
                    addVortexBlock(position)
                case "s":
                    addStarBlock(position)
                case "f":
                    addFinishBlock(position)
                case "t":
                    addTeleportBlock(position)
                case "e":
                    addTeleportExitBlock(position)
                case " ":
                    break
                default:
                    fatalError("Unknown symbol \"\(letter)\" in level file")
                }
            }
        }
    }

    func createPlayer(at location: CGPoint = CGPoint(x: 96, y: 672)) {
        player = SKSpriteNode(imageNamed: "player")
        player.position = location
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue | CollisionTypes.teleport.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        player.zPosition = 1
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard !isGameOver else { return }
        
        #if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition {
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x, y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        switch node.name {
        case "vortex":
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        case "star":
            node.removeFromParent()
            score += 1
        case "teleport":
            guard let location = teleportExit?.position else { fatalError("No exit froim teleport!") }
            
            player.physicsBody?.isDynamic = false
            isGameOver = true
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            player.run(sequence) { [weak self] in
                self?.createPlayer(at: location)
                self?.isGameOver = false
            }
        case "finish":
            isGameOver = true
            finishLevel()
        default:
            fatalError("Unknown contact")
        }
    }
    
    func finishLevel() {
        currentLevel += 1
        if currentLevel >= levels.count {
            currentLevel = 0
        }
        removeAllChildren()
        drawHUD()
        loadLevel()
        createPlayer()
        isGameOver = false
    }
}
