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
        //cloudLabel.font = UIFont.comicoro(size: 20) 
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTitle() {
        addSubview(cloudLabel)
        setBackgroundImage(UIImage(named: "cloudImage"), for: .normal)
        if let customFont = UIFont(name: "Comicoro", size: 40) {
                  cloudLabel.font = customFont
              } else {
                  cloudLabel.font = UIFont.systemFont(ofSize: 40)
              }

        cloudLabel.pinCenterX(to: self)
        cloudLabel.pinCenterY(to: self)
    }
}
