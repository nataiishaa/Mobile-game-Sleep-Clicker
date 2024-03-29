//
//  ImproveCell.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

import UIKit

final class ImproveCell: UICollectionViewCell {
    var improve: Boost?
    
    let improveImageView: UIImageView = {
        return UIImageView()
    }()
    
    let improveNameLabel: UILabel = {
        return UILabel()
    }()
    
    let improvePriceLabel: UILabel = {
        return UILabel()
    }()
    
    let improveTimeLabel: UILabel = {
        return UILabel()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    var onNameTapped: (() -> Void)?
    
    func setHero(improve: Boost) {
        self.improve = improve
        configureUI()
        
    }
    
    private func configureUI() {
        improveImageView.image = improve?.imageBoost
        addSubview(improveImageView)
        addSubview(improveNameLabel)
        addSubview(improvePriceLabel)
        addSubview(improveTimeLabel)
        improveImageView.pinCenterX(to: self.centerXAnchor)
        improveImageView.pinTop(to: self.topAnchor, 5)
        improveImageView.setWidth(70)
        improveImageView.setHeight(130)
        improveNameLabel.pinCenterX(to: self.centerXAnchor)
        improveNameLabel.pinTop(to: improveImageView.bottomAnchor, 5)
        improvePriceLabel.pinCenterX(to: self.centerXAnchor)
        improvePriceLabel.pinTop(to: improveNameLabel.bottomAnchor, 5)
        improveTimeLabel.pinCenterX(to: self.centerXAnchor)
        improveTimeLabel.pinTop(to: improvePriceLabel.bottomAnchor, 5)
        
        
        
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
        improveImageView.image = improve?.imageBoost
    }
}

