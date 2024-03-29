//
//  BoostCell.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

//

import UIKit

final class BoostCell: UICollectionViewCell {
    var hero: Character?
    
    let heroImageView: UIImageView = {
        return UIImageView()
    }()
    
    let heroNameLabel: UILabel = {
        return UILabel()
    }()
    
    let heroHPLabel: UILabel = {
        return UILabel()
    }()
    
    let heroSleepinessLabel: UILabel = {
        return UILabel()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    var onNameTapped: (() -> Void)?

    func setHero(hero: Character) {
        self.hero = hero
        configureUI()
            
    }
    
    private func configureUI() {
        heroImageView.image = hero?.sleepState == .awake ? hero?.imageAwake : hero?.imageSleep
        addSubview(heroImageView)
        addSubview(heroNameLabel)
        addSubview(heroHPLabel)
        addSubview(heroSleepinessLabel)
        heroImageView.pinCenterX(to: self.centerXAnchor)
        heroImageView.pinTop(to: self.topAnchor, 5)
        heroImageView.setWidth(70)
        heroImageView.setHeight(130)
        heroNameLabel.pinCenterX(to: self.centerXAnchor)
        heroNameLabel.pinTop(to: heroImageView.bottomAnchor, 5)
        heroHPLabel.pinCenterX(to: self.centerXAnchor)
        heroHPLabel.pinTop(to: heroNameLabel.bottomAnchor, 5)
        heroSleepinessLabel.pinCenterX(to: self.centerXAnchor)
        heroSleepinessLabel.pinTop(to: heroHPLabel.bottomAnchor, 5)
        
       
        
//
//        // Добавление жеста касания к heroImageView
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//
//                heroImageView.isUserInteractionEnabled = true
//                heroImageView.addGestureRecognizer(tapGesture)
        
        
       
    }
    @objc private func heroNameTapped() {
        onNameTapped?()
    }

//    @objc private func handleTap() {
//            hero.toggleSleepState() // Переключаем состояние сна
//
//            updateUI() // Обновляем UI
//        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func updateUI() {
           heroImageView.image = hero?.sleepState == .awake ? hero?.imageAwake : hero?.imageSleep
       }
}

