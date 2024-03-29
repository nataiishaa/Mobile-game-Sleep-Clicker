//
//  MainModelDTO.swift
//  SleepMobApp
//
//

struct MainModelDTO {
    var items: [CharacterItem]
}

extension MainModelDTO {
    
    struct CharacterItem {
        let type: CharacterType
        var state: SleepState = .awake
        
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
            "\(self.rawValue)Awake"
        }
        
        var imageSleepName: String {
            "\(self.rawValue)Sleep"
        }
    }
    
    public enum SleepState {
        case asleep
        case awake
        
        var next: SleepState {
            switch self {
            case .asleep:
                return .awake
            case .awake:
                return .asleep
            }
        }
    }
}
