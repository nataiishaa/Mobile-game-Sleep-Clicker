//
//  BoostCollectionViewCell.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 30.03.2024.
//

import UIKit

class BoostCollectionViewCell: UICollectionViewCell {
    
    var boostImageView: UIImageView!
    var timerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        boostImageView = UIImageView()
        contentView.addSubview(boostImageView)
        
        timerLabel = UILabel()
        contentView.addSubview(timerLabel)
        timerLabel.textColor = .white
        timerLabel.font = .comicoro(size: 25)
        timerLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        boostImageView.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boostImageView.heightAnchor.constraint(equalToConstant: 30),
            boostImageView.widthAnchor.constraint(equalToConstant: 30),
            boostImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            boostImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            timerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            timerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            timerLabel.topAnchor.constraint(equalTo: boostImageView.bottomAnchor),
            timerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
