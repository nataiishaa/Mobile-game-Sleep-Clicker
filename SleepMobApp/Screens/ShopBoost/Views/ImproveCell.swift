//
//  ImproveCell.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

import UIKit

final class ImproveCell: UICollectionViewCell {
    
    let improveImageView: UIImageView = {
        return UIImageView()
    }()
    
    let improveNameLabel: UILabel = {
        let label = UILabel()
        label.font = .comicoro(size: 15)
        return label
    }()
    
    let improvePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .comicoro(size: 15)
        return label
    }()
    
    let improveDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .comicoro(size: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2509803922, blue: 0.7333333333, alpha: 1)
        configureUI()
    }
    
    private func configureUI() {
        improveImageView.contentMode = .scaleAspectFit
        addSubview(improveImageView)
        addSubview(improveNameLabel)
        addSubview(improvePriceLabel)
        addSubview(improveDescriptionLabel)
        improveImageView.pinCenterX(to: self.centerXAnchor)
        improveImageView.pinTop(to: self.topAnchor, 5)
        improveImageView.setWidth(70)
        improveImageView.setHeight(130)
        improveNameLabel.pinCenterX(to: self.centerXAnchor)
        improveNameLabel.pinTop(to: improveImageView.bottomAnchor, 5)
        improvePriceLabel.pinCenterX(to: self.centerXAnchor)
        improvePriceLabel.pinTop(to: improveNameLabel.bottomAnchor, 5)
        improveDescriptionLabel.pinCenterX(to: self.centerXAnchor)
        improveDescriptionLabel.pinTop(to: improvePriceLabel.bottomAnchor, 5)
        improveDescriptionLabel.pinLeft(to: leadingAnchor, 5)
        improveDescriptionLabel.pinRight(to: trailingAnchor, 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

