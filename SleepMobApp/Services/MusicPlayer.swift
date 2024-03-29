//
//  MusicPlayer.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 14.03.2024.
//

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "backgroundMusic", ofType: "wav") {
            let backgroundMusicUrl = URL(fileURLWithPath: bundle)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusicUrl)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1 // Бесконечное повторение
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    
    func isMusicPlaying() -> Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    func toggleMusic() {
        if isMusicPlaying() {
            stopBackgroundMusic()
        } else {
            startBackgroundMusic()
        }
    }
}

