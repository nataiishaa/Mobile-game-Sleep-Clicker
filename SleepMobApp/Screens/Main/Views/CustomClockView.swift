//  CustomClockView.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 27.03.2024.
//

import UIKit

class CustomClockView: UIView {
    
    private var timeLabel: UILabel!
    var timer: Timer?
    private var timeElapsed: TimeInterval = 0
    private var speedMultiplier: TimeInterval = 60
    private var startTime: Date?
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTimeLabel()
        resetTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTimeLabel()
        resetTimer()
    }
    
    private func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 40)
        timeLabel.textColor = .cyan
        timeLabel.textAlignment = .center
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        startTime = Date()
    }
    
    @objc private func updateTime() {
        guard let startTime = startTime else { return }
        let currentTime = Date()
        timeElapsed = currentTime.timeIntervalSince(startTime) * speedMultiplier
        
        // Format the timeElapsed to hours and minutes
        let minutes = Int(timeElapsed) / 3600
        let seconds = (Int(timeElapsed) % 3600) / 60
        timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func changeSpeed(newSpeed: TimeInterval) {
        speedMultiplier = newSpeed
        startTime = newSpeed == 0 ? nil : Date()
    }
    
    // Call this method to transition to a new day
    func newDay() {
        let targetTime: TimeInterval = 24 * 60 * 60 // Seconds in a day
        goToTime(time: targetTime, duration: 3)
    }
    
    private func goToTime(time: TimeInterval, duration: TimeInterval) {
        // Просто устанавливаем timeElapsed в целевое время и обновляем startTime, чтобы таймер продолжил с этой точки
            timeElapsed = time
            startTime = Date().addingTimeInterval(-timeElapsed / speedMultiplier)
            updateTime() // Немедленно обновляем отображаемое время
    }
}
