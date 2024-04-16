//
//  MainModelDTO.swift
//  SleepMobApp
//
//

class MainModelDTO {
    var items = [CharacterModel]()
    var boosts = [BoostModel]()
}

enum SleepState: String {
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
    
    var imageBuyName: String {
        "\(self.rawValue)ToBuy"
    }
    
    var price: Int {
        switch self {
        case .baby: 5
        case .student: 5
        case .police: 10
        case .dad: 10
        case .cat: 15
        case .bear: 15
        }
    }
}
