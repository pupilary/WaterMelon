//
//  AudioFactory.swift
//  WaterMelon
//
//  Created by TAKESI NANASE on 2021/6/15.
//

import AVFoundation

class AudioFactory {
    
    static let shared: (String) -> AudioFactory = { resourceName in
        AudioFactory(resourceName: resourceName)
    }
    
    var resourceName: String
    var player: AVAudioPlayer!
    var playing = false
    
    init(resourceName: String) {
        self.resourceName = resourceName
    }
    
    func playAudio() {
        if playing {
            return
        }
        
        guard let fileUrl = Bundle.main.url(forResource: resourceName, withExtension: "mp3") else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: fileUrl)
            player.prepareToPlay()
            player.play()
            playing = true
        } catch let err {
            print(err.localizedDescription)
        }
        Timer(timeInterval: 1, repeats: false) { _ in
            self.playing = false
        }
        .fire()
    }
    
}
