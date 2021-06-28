//
//  GameScene+LoadUI.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/14.
//

import SpriteKit
import SwiftUI

// MARK: - loadUI
extension GameScene {
    
    override func didMove(to view: SKView) {
        view.showsFPS = true
        view.showsNodeCount = true
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.fruitFactory = .shared
        self.makeUI()
        self.makeNowFruit()
        self.makeScoreNode()
        self.makeRedLine()
    }
    
    private func makeScoreNode() {
        scoreNode = SKSpriteNode()
        scoreNode.position = CGPoint(x: 30.0, y: SCREEN.height - 50.0)
        scoreNode.setScale(0.5)
        addChild(scoreNode)
        
        self.updateScore()
    }
    
    func updateScore() {
        scoreNode.removeAllChildren()
        
        var scoreCopy = score
        var arr: [Int] = []
        
        if scoreCopy == 0 {
            arr.append(0)
        } else {
            while scoreCopy != 0 {
                arr.append(scoreCopy % 10)
                scoreCopy /= 10
            }
        }
        var cnt: CGFloat = 0.0
        
        while arr.count != 0 {
            let last = arr.popLast()!
            let node = SKSpriteNode(imageNamed: "number/\(last)")
            node.position = CGPoint(x: cnt * 70.0, y: 0.0)
            cnt += 1
            scoreNode.addChild(node)
        }
     }
    
    private func makeNowFruit() {
        nowFruit = fruitFactory.randomFruit()
        addChild(nowFruit)
    }
    
    private func makeUI() {
        let background = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.9843137255, green: 0.9098039216, blue: 0.6509803922, alpha: 1)), size: CGSize(width: SCREEN.width, height: SCREEN.height))
        background.anchorPoint = .zero
        background.position = .zero
        addChild(background)
        
        let solid = SKSpriteNode(color: #colorLiteral(red: 0.4588235294, green: 0.3333333333, blue: 0.2352941176, alpha: 1), size: CGSize(width: SCREEN.width, height: SCREEN.height / 5))
        solid.anchorPoint = .zero
        solid.position = .zero
        addChild(solid)
        
        ground = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.6745098039, green: 0.537254902, blue: 0.3490196078, alpha: 1)), size: CGSize(width: SCREEN.width, height: 10.0))
        ground.anchorPoint = .zero
        ground.position = CGPoint(x: 0.0, y: SCREEN.height / 5)
        ground.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0.0, y: ground.size.height), to: CGPoint(x: ground.size.width, y: ground.size.height))
        ground.physicsBody?.categoryBitMask =  0xFFFFFFFF >> 1
        ground.physicsBody?.contactTestBitMask =  0xFFFFFFFF >> 1
        addChild(ground)
    }
}

