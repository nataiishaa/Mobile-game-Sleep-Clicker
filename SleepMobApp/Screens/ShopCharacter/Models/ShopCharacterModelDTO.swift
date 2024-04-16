//
//  ShopCharacterModelDTO.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 29.03.2024.
//

struct ShopCharacterModelDTO {
    var items: [ImproveItem]
}

extension ShopCharacterModelDTO {
    
    struct ImproveItem {
        let type: CharacterType
        
        init(type: CharacterType) {
            self.type = type
        }
    }
}

