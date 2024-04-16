//
//  BoostModel+CoreDataClass.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 30.03.2024.
//
//

import CoreData

@objc(BoostModel)
public class BoostModel: NSManagedObject {
    var boostType: BoostType {
        get {
            BoostType(rawValue: rawBoostType) ?? .cap1
        }
        set {
            rawBoostType = newValue.rawValue
        }
    }
    
    convenience init(type: BoostType) {
        self.init(entity: Self.entity(), insertInto: nil)
        rawBoostType = type.rawValue
        timer = type.actionTime
        creationDate = Date()
    }
}

extension BoostModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BoostModel> {
        return NSFetchRequest<BoostModel>(entityName: "BoostModel")
    }

    @NSManaged public var creationDate: Date
    @NSManaged public var rawBoostType: String
    @NSManaged public var timer: Int
}

extension BoostModel: Identifiable { }
