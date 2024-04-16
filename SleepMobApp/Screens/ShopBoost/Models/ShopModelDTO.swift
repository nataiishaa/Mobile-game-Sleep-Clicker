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
        let type: BoostType
        //var state: SleepState = .awake
        
        init(type: BoostType) {
            self.type = type
        }
    }
}

enum BoostType: String {
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
    
    var price: Int {
        switch self {
        case .cap1: 30
        case .cap2: 70
        case .mask: 100
        case .fairy: 120
        }
    }
    
    var priceMultiplier: Int {
        switch self {
        case .cap1: 2
        case .cap2: 4
        case .mask: 1
        case .fairy: 1
        }
    }
    
    var actionTime: Int {
        switch self {
        case .cap1: 240
        case .cap2: 120
        case .mask: 0
        case .fairy: 60
        }
    }
    
    var descriptionBoost: String {
        switch self {
        case .cap1:
            "Currency multiplier by 2 (4 min.)"
        case .cap2:
            "Currency multiplied by 4 (2 min.)"
        case .mask:
            "HP 100%"
        case .fairy:
            "Autoclicker (1 min.)"
        }
    }
    
    var imageBoostName: String {
        "\(self.rawValue)Boost"
    }
}
