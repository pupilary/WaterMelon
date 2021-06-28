//
//  FruitFactory.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/14.
//

import Foundation
import SpriteKit

class FruitFactory {
    
    static let shared: FruitFactory = FruitFactory()
    
    private let randomList: [FruitTexture] = [
        .grape,
        .cherry,
        .orange,
        .lemon,
        .kiwi
    ]
    private var randomCount = 0
    
    private var mixList: [FruitTexture] = [
        .grape,
        .cherry,
        .orange,
        .lemon,
        .kiwi,
        .tomato,
        .peach,
        .pineapple,
        .cocount,
        .halfwatermelon,
        .watermelon
    ]
    
    func randomFruit() -> SKSpriteNode {
        randomCount += 1
        var fruit: SKSpriteNode;
        var fruitTexture: FruitTexture
        
        switch randomCount {
        case 1...3:
            fruitTexture = FruitTexture.grape
        case 4:
            fruitTexture = FruitTexture.cherry
        case 5:
            fruitTexture = FruitTexture.orange
        default:
            fruitTexture = randomList.randomElement()!
        }
        fruit = SKSpriteNode(imageNamed: fruitTexture.name)
        fruit.position = CGPoint(x: SCREEN.width / 2, y: SCREEN.height - 50.0)
        fruit.setScale(0.5)
        fruit.name = fruitTexture.name
       return fruit
    }
    
    func getFruitScore(fruitName: String) -> Int {
        mixList.firstIndex { $0.name == fruitName }! + 1
    }
    
    func mixFruit(fruitName: String) -> SKSpriteNode? {
        let index = mixList.firstIndex { fruitName == $0.name }
        
        if index == nil || index! == mixList.count - 1 {
            return nil
        }
        let name = mixList[index! + 1].name
        let fruit = SKSpriteNode(imageNamed: name)
        fruit.name = name
        return fruit
    }
    
    func getFruitTextureByName(fruitName: String) -> FruitTexture {
        FruitTexture.allCases.first { $0.name == fruitName }!
    }
}
