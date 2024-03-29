//
//  Boost.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//
import UIKit

final class Boost {
    public var name: String
    public var time: Int
    public var price: Int
    public var imageBoost: UIImage?
    
    
    init(
        name: String,
        imageBoost: UIImage?
        
    ) {
        self.name = name
        self.imageBoost = imageBoost
        self.price = 100
        self.time = 3000
    }
}

