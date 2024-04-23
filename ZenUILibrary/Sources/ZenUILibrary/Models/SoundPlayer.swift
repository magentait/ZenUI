//
//  SoundPlayer.swift
//  ZenUI
//
//  Created by David on 25.03.2024.
//

import AVFoundation

class SoundPlayer {
    var audioPlayer: AVAudioPlayer?

    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Не удалось найти и воспроизвести звуковой файл")
            }
        }
    }
}
