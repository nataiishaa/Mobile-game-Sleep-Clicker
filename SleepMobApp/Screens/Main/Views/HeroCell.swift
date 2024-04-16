//
//  HeroCell.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 14.03.2024.
//

import UIKit

final class HeroCell: UICollectionViewCell {
    
    var heroImageView: UIImageView!
    var heroNameLabel: UILabel!
    var heartOneImageView: UIImageView!
    var heartTwoImageView: UIImageView!
    var heartThreeImageView: UIImageView!
    var batteryImageView: UIImageView!
    var heroHPLabel: UILabel!
    
    var lives = 3 {
        didSet {
            heartOneImageView.isHidden = lives <= 0
            heartTwoImageView.isHidden = lives <= 1
            heartThreeImageView.isHidden = lives <= 2
        }
    }
    
    var sleepiness = 10 {
        didSet {
            if sleepiness <= 20 {
                batteryImageView.image = .batteryLow
            } else if sleepiness >= 80 {
                batteryImageView.image = .batteryHigh
            } else {
                batteryImageView.image = .batteryMiddle
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(hero: CharacterViewData) {
        heroImageView.image = hero.image
        lives = hero.lives
        sleepiness = hero.sleepiness
        
        let colorOne = #colorLiteral(red: 0.8433896899, green: 0.7258818746, blue: 0.7231372595, alpha: 1)
        let colorTwo = #colorLiteral(red: 1, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        
        heroNameLabel.attributedText = NSAttributedString(string: hero.name, attributes: [.strokeColor: colorTwo,
                                                                                          .foregroundColor: colorOne,
                                                                                          .strokeWidth: 8,
                                                                                          .font: UIFont.comicoro(size: 12)])
        
        heroHPLabel.attributedText = NSAttributedString(string: "HP \(hero.hp) / 100", attributes: [.strokeColor: colorTwo,
                                                                                          .foregroundColor: colorOne,
                                                                                          .strokeWidth: 8,
                                                                                          .font: UIFont.comicoro(size: 12)])
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2509803922, blue: 0.7333333333, alpha: 1)
        
        heroImageView = UIImageView()
        contentView.addSubview(heroImageView)
        heroImageView.contentMode = .scaleAspectFit
        
        heroNameLabel = UILabel()
        contentView.addSubview(heroNameLabel)
        heroNameLabel.textAlignment = .center
        heroNameLabel.layer.shadowRadius = 2
        heroNameLabel.layer.shadowOffset = .init(width: 0, height: 4)
        heroNameLabel.layer.shadowOpacity = 0.25
        heroNameLabel.layer.shadowColor = UIColor.black.cgColor
        
        heartOneImageView = UIImageView(image: .heart)
        contentView.addSubview(heartOneImageView)
        
        heartTwoImageView = UIImageView(image: .heart)
        contentView.addSubview(heartTwoImageView)
        
        heartThreeImageView = UIImageView(image: .heart)
        contentView.addSubview(heartThreeImageView)
        
        batteryImageView = UIImageView(image: .batteryLow)
        contentView.addSubview(batteryImageView)
        
        heroHPLabel = UILabel()
        contentView.addSubview(heroHPLabel)
        heroHPLabel.layer.shadowRadius = 2
        heroHPLabel.layer.shadowOffset = .init(width: 0, height: 4)
        heroHPLabel.layer.shadowOpacity = 0.25
        heroHPLabel.layer.shadowColor = UIColor.black.cgColor
    }
    
    private func setupConstraints() {
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroNameLabel.translatesAutoresizingMaskIntoConstraints = false
        heartOneImageView.translatesAutoresizingMaskIntoConstraints = false
        heartTwoImageView.translatesAutoresizingMaskIntoConstraints = false
        heartThreeImageView.translatesAutoresizingMaskIntoConstraints = false
        batteryImageView.translatesAutoresizingMaskIntoConstraints = false
        heroHPLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            heroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            heroNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            heroNameLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 12),
            heroNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            heroNameLabel.heightAnchor.constraint(equalToConstant: 14),
            
            heartOneImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            heartOneImageView.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor, constant: 9),
            heartOneImageView.heightAnchor.constraint(equalToConstant: 13),
            heartOneImageView.widthAnchor.constraint(equalToConstant: 17),
            
            heartTwoImageView.leadingAnchor.constraint(equalTo: heartOneImageView.trailingAnchor, constant: -2),
            heartTwoImageView.centerYAnchor.constraint(equalTo: heartOneImageView.centerYAnchor),
            heartTwoImageView.heightAnchor.constraint(equalTo: heartOneImageView.heightAnchor),
            heartTwoImageView.widthAnchor.constraint(equalTo: heartOneImageView.widthAnchor),
            
            heartThreeImageView.leadingAnchor.constraint(equalTo: heartTwoImageView.trailingAnchor, constant: -2),
            heartThreeImageView.centerYAnchor.constraint(equalTo: heartOneImageView.centerYAnchor),
            heartThreeImageView.heightAnchor.constraint(equalTo: heartOneImageView.heightAnchor),
            heartThreeImageView.widthAnchor.constraint(equalTo: heartOneImageView.widthAnchor),
            
            batteryImageView.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor, constant: 13),
            batteryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            batteryImageView.heightAnchor.constraint(equalToConstant: 16),
            batteryImageView.widthAnchor.constraint(equalToConstant: 27),
            
            heroHPLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            heroHPLabel.topAnchor.constraint(equalTo: heartOneImageView.bottomAnchor, constant: 4),
            heroHPLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),
            heroHPLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
            heroHPLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
}
