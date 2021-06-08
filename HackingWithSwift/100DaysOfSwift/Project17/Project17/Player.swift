//
//  Player.swift
//  Project17
//
//  Created by Andrei Chenchik on 2/6/21.
//

import SpriteKit

class Player: SKSpriteNode {
    var direction: CGPoint?
    var possibleSpeed: CGFloat = 800.0
    
    init(imageNamed name: String) {
        let texture = SKTexture(imageNamed: name)
        let size = texture.size()
        super.init(texture: texture, color: .clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
