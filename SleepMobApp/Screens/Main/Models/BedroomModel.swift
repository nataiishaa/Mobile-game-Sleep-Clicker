//
//  BedroomModel.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 16.04.2024.
//

import Foundation

enum BedroomModel {
    enum Start {
        struct Request { }
        struct Response {
            var balance: Int
            var boosts: [BoostModel]
            var characters: [CharacterModel]
        }
        
        struct ViewModel {
            var balance: Int
            var characters: [CharacterViewData]
            var boostViewData: [BoostViewData]
            var isAutoClick: Bool
        }
    }
    
    enum Tap {
        struct Request {
            var index: Int
        }
    }
    
    enum Stop {
        struct Request { }
    }
}
