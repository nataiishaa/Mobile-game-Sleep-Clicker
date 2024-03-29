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
        //var state: SleepState = .awake
        
        init(type: CharacterType) {
            self.type = type
        }
    }
    
    enum CharacterType: String {
        case baby
        case student
        case police
        case dad
        case cat
        case bear
        
        var name: String {
            switch self {
            case .baby:
                "Baby"
            case .student:
                "Student"
            case .police:
                "Police"
            case .dad:
                "Dad"
            case .cat:
                "Cat"
            case .bear:
                "Bear"
            }
        }
        
        
        var imageAwakeName: String {
            "\(self.rawValue)ToBuy"
        }
        
      
    }
    
    enum SleepState {
        case asleep
        case awake
        
    }
}

