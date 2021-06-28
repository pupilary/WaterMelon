//
//  ContentView.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/13.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: SCREEN.width, height: SCREEN.height)
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: SCREEN.width, height: SCREEN.height)
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
