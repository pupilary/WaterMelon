//
//  GameScene.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/13.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var nowFruit: SKSpriteNode!
    var scoreNode: SKSpriteNode!
    
    var score: Int = 0 {
        didSet {
            self.updateScore()
        }
    }
    var groundFruits: [SKSpriteNode] = []
    var fruitFactory: FruitFactory!
    var ground: SKSpriteNode!
    var redLine: SKSpriteNode!
    var isShowingRedLine = false
    
    var groundCollision = false
    
    let falldownAudio: AudioFactory = .shared("falldown")
    let winAudio: AudioFactory = .shared("win")
    let bombAudio: AudioFactory = .shared("bomb")
    
    override func update(_ currentTime: TimeInterval) {
        if isShowingRedLine {
            if !checkWillShowingRedline() {
                showOutRedLine()
                isShowingRedLine = false
            }
        } else {
            if checkWillShowingRedline() {
                showInRedLine()
                isShowingRedLine = true
            }
        }
    }
    
    private func checkWillShowingRedline() -> Bool {
        for fruit in groundFruits {
            if fruit.position.y > SCREEN.height - 80 - 150 {
                return true
            }
        }
        return false
    }
    
}

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
