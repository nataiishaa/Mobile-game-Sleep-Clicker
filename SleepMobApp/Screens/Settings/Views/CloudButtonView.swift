//
//  CloudButtonView.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//

import  UIKit
final class CloudButtonView : UIButton {
    private let cloudLabel: UILabel = UILabel()
    
    
    init(title: String) {
        super.init(frame: CGRect())
        cloudLabel.text = title
        configureTitle()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitle() {
        addSubview(cloudLabel)
        setBackgroundImage(UIImage(named: "cloudImage"), for: .normal)
        cloudLabel.font = UIFont.boldSystemFont(ofSize: 25)
        cloudLabel.pinCenterX(to: self)
        cloudLabel.pinCenterY(to: self)
    }
}
