//
//  ShopCharacterCollectionViewCell.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 12.03.2024.
//

import UIKit

class ShopCharacterCollectionViewCell: UICollectionViewCell {
    
    var heroImageView: UIImageView!
    var heroNameLabel: UILabel!
    var balanceImageView: UIImageView!
    var priceLabel: UILabel!
    var balanceStackView: UIStackView!
    
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
        priceLabel.text = String(hero.price)
        heroNameLabel.text = hero.name
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2509803922, blue: 0.7333333333, alpha: 1)
        
        heroImageView = UIImageView()
        contentView.addSubview(heroImageView)
        heroImageView.contentMode = .scaleAspectFit
        
        heroNameLabel = UILabel()
        contentView.addSubview(heroNameLabel)
        heroNameLabel.textAlignment = .center
        heroNameLabel.textColor = .white
        heroNameLabel.font = .comicoro(size: 15)
        
        priceLabel = UILabel()
        priceLabel.font = .comicoro(size: 15)
        priceLabel.textColor = .white
        
        balanceImageView = UIImageView(image: .balance)
        
        balanceStackView = UIStackView(arrangedSubviews: [balanceImageView, priceLabel])
        contentView.addSubview(balanceStackView)
    }
    
    private func setupConstraints() {
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroNameLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            heroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            heroNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            heroNameLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 12),
            heroNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            heroNameLabel.heightAnchor.constraint(equalToConstant: 14),
            
            balanceImageView.heightAnchor.constraint(equalToConstant: 29),
            balanceImageView.widthAnchor.constraint(equalToConstant: 29),
            
            balanceStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            balanceStackView.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor, constant: 0),
            balanceStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
        ])
    }
}
