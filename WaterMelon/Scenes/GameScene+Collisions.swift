//
//  GameScene+Collisions.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/14.
//

import SpriteKit


// MARK: - Collision
extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if groundCollision {
            return
        }
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        // ground collision
        for fruit in FruitTexture.allCases {
            let bit = fruit.bitmask | ground.physicsBody!.categoryBitMask
            
            if bit == collision {
                groundCollision = true
                falldownAudio.playAudio()
                Timer(timeInterval: 1, repeats: false) {_ in
                    self.groundCollision = false
                }
                .fire()
                break
            }
        }
        
        for fruit in FruitTexture.allCases {
            let fruitBit = fruit.bitmask | fruit.bitmask
            
            if fruitBit == collision {
                bombAudio.playAudio()
                let nodeA = contact.bodyA.node!
                let nodeB = contact.bodyB.node!
                
                // two watermelon collision
                if  nodeA.name == FruitTexture.watermelon.name {
                    return
                } else {
                  let score = fruitFactory.getFruitScore(fruitName: nodeA.name!)
                    self.score += score
                    
                    if nodeA.name! == FruitTexture.halfwatermelon.name {
                        self.score += 100
                        showBonusAnimation()
                        winAudio.playAudio()
                    }
                }
                let newFruitPosition = CGPoint(
                    x: (nodeA.position.x + nodeB.position.x) / 2,
                    y: (nodeA.position.y + nodeB.position.y) / 2
                )
                run(.sequence([
                    .run {
                        nodeA.run(.fadeOut(withDuration: 0.1))
                        nodeB.run(.fadeOut(withDuration: 0.1))
                    },
                    .run {
                        nodeA.removeFromParent()
                        nodeB.removeFromParent()
                    },
                    .run {
                        self.generateFruitFromCollisiton(fruitName: nodeA.name!, position: newFruitPosition)
                    }
                ]))
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
    private func showBonusAnimation() {
        let bonusNode = SKSpriteNode()
        bonusNode.position = CGPoint(x: SCREEN.width / 2, y: SCREEN.height / 2)
        let watermelon = SKSpriteNode(imageNamed: FruitTexture.watermelon.name)
        let yellowLight = SKSpriteNode(imageNamed: "yellowlight")
        let gray = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.4)), size: CGSize(width: SCREEN.width, height: SCREEN.height))
        
        let layer = SKSpriteNode()
        
        watermelon.position = .zero
        watermelon.setScale(0.3)
        yellowLight.position = .zero
        
        layer.addChild(yellowLight)
        layer.addChild(watermelon)
        
        bonusNode.addChild(gray)
        bonusNode.addChild(layer)
        addChild(bonusNode)
        
        yellowLight.run(
            .rotate(byAngle: 30, duration: 30)
        )
        
        layer.setScale(0.1)
        layer.position = CGPoint(x: 0.0, y: 50.0)
        layer.run(.sequence([
            .scale(to: 1.0, duration: 0.5),
            .wait(forDuration: 1),
            .scale(to: 0.0, duration: 0.5)
        ]))
        layer.run(.sequence([
            .moveTo(y: 150.0, duration: 0.1),
            .moveTo(x: 0.0, duration: 0.4),
            .wait(forDuration: 1),
            .moveTo(y: 500.0, duration: 0.5),
            .run {
                bonusNode.run(.fadeOut(withDuration: 0.1))
                bonusNode.removeFromParent()
            }
        ]))
    }
    
    private func generateFruitFromCollisiton(fruitName: String, position: CGPoint) {
        guard let fruit = fruitFactory.mixFruit(fruitName: fruitName) else { return }
        fruit.position = position
        fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.height / 2)
        let bitmask = fruitFactory.getFruitTextureByName(fruitName: fruit.name!).bitmask
        fruit.physicsBody?.categoryBitMask = bitmask
        fruit.physicsBody?.contactTestBitMask = bitmask
        addChild(fruit)
        fruit.setScale(0.0)
        fruit.run(.scale(to: 0.5, duration: 0.3))
    }
}
