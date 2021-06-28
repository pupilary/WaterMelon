//
//  GameScene+RedLine.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/15.
//

import SwiftUI
import SpriteKit

extension GameScene {
    
    func makeRedLine() {
        redLine = SKSpriteNode(imageNamed: "redline")
        redLine.anchorPoint = .zero
        redLine.position = CGPoint(x: 0.0, y: SCREEN.height - 80.0)
        
        addChild(redLine)
        
        redLine.run(.repeat(.sequence([
            .fadeIn(withDuration: 0.4),
            .fadeOut(withDuration: 0.4)
        ]), count: -1))
    }
    
    func showInRedLine() {
        redLine.setScale(1.0)
    }
    
    func showOutRedLine() {
        redLine.setScale(0.0)
    }
}
