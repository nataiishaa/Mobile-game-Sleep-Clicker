
//
//  Сharacter.swift
//  MobileApp_Sleep
//
//  Created by Наталья Захарова on 27.02.2024.
//
import UIKit

final class Character {
    public var name: String
    public var hp: Int
    public var sleepiness: Int
    public var imageAwake: UIImage?
    public var imageSleep: UIImage?
    public var sleepState: MainModelDTO.SleepState
    public var startSleepTime = Date()
    public var awakeSleepTime = Date()
    
    init(
        name: String,
        imageAwake: UIImage?,
        imageSleep: UIImage?,
        sleepState: MainModelDTO.SleepState
    ) {
        self.name = name
        self.imageAwake = imageAwake
        self.imageSleep = imageSleep
        self.sleepState = sleepState
        self.hp = 100
        self.sleepiness = 100
    }
    
    
}

extension Character {
    func startSleeping() {
        sleepState = .asleep // Предполагая, что .sleep обозначает спящее состояние
        startSleepTime = Date()
    }

    func stopSleeping() {
        awakeSleepTime = Date()
        let sleepDuration = awakeSleepTime.timeIntervalSince(startSleepTime)
        if sleepDuration > 0.13 {
            hp -= 10 // Отнимаем HP, например, 10 очков здоровья за каждые 8 секунд сна
        }
        sleepState = .awake
    }
}


