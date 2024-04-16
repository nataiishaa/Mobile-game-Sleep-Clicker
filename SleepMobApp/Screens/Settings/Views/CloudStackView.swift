//
//  CloudStackView.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 13.03.2024.
//

import UIKit

final class CloudStackView: UIView {
    let soundCloud = CloudButtonView(title: "sound")
    let notificationCloud = CloudButtonView(title: "notification")
    let infoClous = CloudButtonView(title: "about dev")
    
    
    let stackView = UIStackView()
    
    override init (frame: CGRect) {
        super.init(frame:frame)
        addSubview(stackView)
        configureUI()
    }
    
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.clipsToBounds = true
        
        for cloud in [soundCloud,notificationCloud,infoClous]{
            stackView.addArrangedSubview(cloud)
        }
        
    }
}
