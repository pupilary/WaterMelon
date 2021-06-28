//
//  GameScene+Touches.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/14.
//

import SpriteKit
import SwiftUI

// MARK: - Touches
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        nowFruit.run(.sequence([
            .moveTo(x: location.x, duration: 0.1),
            .run {
                self.nowFruit.physicsBody = SKPhysicsBody(circleOfRadius: self.nowFruit.size.height / 2)
                let bitmark = self.fruitFactory.getFruitTextureByName(fruitName: self.nowFruit.name!).bitmask
                self.nowFruit.physicsBody?.categoryBitMask = bitmark
                self.nowFruit.physicsBody?.contactTestBitMask = bitmark
            },
            .wait(forDuration: 0.5),
            .run {
                self.groundFruits.append(self.nowFruit)
                self.nowFruit = self.fruitFactory.randomFruit()
                self.addChild(self.nowFruit)
                self.nowFruit.setScale(0.0)
                self.nowFruit.run(.scale(to: 0.5, duration: 0.1))
            }
        ]))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

struct GameSceneTouches_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
