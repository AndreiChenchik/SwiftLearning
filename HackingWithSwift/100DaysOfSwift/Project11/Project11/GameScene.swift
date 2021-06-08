//
//  GameScene.swift
//  Project11
//
//  Created by Andrei Chenchik on 30/5/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let ballColors = ["Red", "Blue", "Cyan", "Green", "Grey", "Purple", "Yellow"]
    var attemptsLabel: SKLabelNode!
    var pins = [SKNode]()
    var balls = [SKNode]()

    let pinsNumber = 10
    
    var attempts = 0 {
        didSet {
            attemptsLabel.text = "Attempts left: \(attempts)"
        }
    }
    
    var editLabel: SKLabelNode!
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Place \(pinsNumber) pins"
            } else {
                editLabel.text = "Destroy all pins"
            }
        }
    }
   
    fileprivate func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius:  bouncer.size.width / 2)
        bouncer.physicsBody?.isDynamic = false
        
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotGlow: SKSpriteNode
        var slotBase: SKSpriteNode
        
        if isGood {
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotBase.name = "good"
        } else {
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotBase.name = "bad"
        }
        
        slotGlow.position = position
        slotBase.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
    
        addChild(slotGlow)
        addChild(slotBase)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    fileprivate func startGame() {
        attempts = 5
        editingMode = true
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        attemptsLabel = SKLabelNode(fontNamed: "Chalkduster")
        attemptsLabel.horizontalAlignmentMode = .right
        attemptsLabel.position = CGPoint(x: 980, y: 700)
        addChild(attemptsLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.horizontalAlignmentMode = .left
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
    
        if editingMode {
            let size = CGSize(width: Int.random(in: 16...128), height: 16)
            let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
            box.zRotation = CGFloat.random(in: 0...3)
            box.position = location
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.isDynamic = false
            
            addChild(box)
            
            pins.append(box)
            
            if pins.count >= pinsNumber {
                editingMode.toggle()
            }
            
        } else if location.y > 500 && attempts > 0 {
            guard let ballColor = ballColors.randomElement() else { fatalError("Colors not found") }
            let ball = SKSpriteNode(imageNamed: "ball\(ballColor)")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
            ball.physicsBody?.restitution = 0.4
            ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
            ball.position = location
            ball.name = "ball"
            
            addChild(ball)
            
            balls.append(ball)
            attempts -= 1
        }
        
    }
    
    func declareVictory() {
        let winAC = UIAlertController(title: "WOW!", message: "You won, incredible. Again?", preferredStyle: .alert)
        winAC.addAction(UIAlertAction(title: "Sure!", style: .default))
        
        view?.window?.rootViewController?.present(winAC, animated: true)
        startGame()
    }
    
    func declareDefeat() {
        let looseAC = UIAlertController(title: "OOPS", message: "LOOOOOOSEEEEER. Again?", preferredStyle: .alert)
        looseAC.addAction(UIAlertAction(title: "OK", style: .default))
        
        view?.window?.rootViewController?.present(looseAC, animated: true)

        
        for pin in pins {
            pin.removeFromParent()
        }
        
        pins.removeAll()
        
        startGame()
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if pins.contains(object) {
            destroy(object: object)
        }
    
        if object.name == "good" {
            attempts += 1
            destroy(object: ball)
        } else if object.name == "bad" {
            destroy(object: ball)
        }
    }
    
    func destroy(object: SKNode) {
        


        
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = object.position
            addChild(fireParticles)
        }
        
        if let index = pins.firstIndex(of: object) {
            pins.remove(at: index)
        } else if let index = balls.firstIndex(of: object) {
            balls.remove(at: index)
        }
        
        object.removeFromParent()
        
        if pins.count == 0 {
            declareVictory()
        }
        
        if balls.count == 0 && attempts == 0 {
            declareDefeat()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
}
