//
//  MainModelDTO.swift
//  SleepMobApp
//
//

struct ShopModelDTO {
    var items: [ImproveItem]
}

extension ShopModelDTO {
    
    struct ImproveItem {
        let type: CharacterType
        //var state: SleepState = .awake
        
        init(type: CharacterType) {
            self.type = type
        }
    }
    
    enum CharacterType: String {
        case cap1
        case cap2
        case mask
        case fairy
   
        
        var name: String {
            switch self {
            case .cap1:
                "Sleep cap"
            case .cap2:
                "Sleep cap"
            case .mask:
                "Mask"
            case .fairy:
                "Fairy Fiona"
       
            }
        }
        
        var imageAwakeName: String {
            "\(self.rawValue)Boost"
        }
        
      
    }
    
    enum SleepState {
        case asleep
        case awake
        
//        var next: SleepState {
//            switch self {
//            case .asleep:
//                return .awake
//            case .awake:
//                return .asleep
//            }
//        }
    }
}
