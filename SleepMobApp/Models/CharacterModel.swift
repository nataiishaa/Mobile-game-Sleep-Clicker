//
//  CharacterModel+CoreDataClass.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 30.03.2024.
//
//

import Foundation
import CoreData

@objc(CharacterModel)
public class CharacterModel: NSManagedObject {
    
    var characterType: CharacterType {
        get {
            CharacterType(rawValue: rawCharacterType) ?? .baby
        }
        set {
            rawCharacterType = newValue.rawValue
        }
    }
    
    var characterState: SleepState {
        get {
            SleepState(rawValue: rawCharacterState) ?? .awake
        }
        set {
            rawCharacterState = newValue.rawValue
        }
    }
    
    convenience init(type: CharacterType) {
        self.init(entity: Self.entity(), insertInto: nil)
        rawCharacterType = type.rawValue
        creationDate = Date()
    }
}

extension CharacterModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterModel> {
        return NSFetchRequest<CharacterModel>(entityName: "CharacterModel")
    }
    
    @NSManaged public var rawCharacterType: String
    @NSManaged public var rawCharacterState: String
    @NSManaged public var hp: Int
    @NSManaged public var sleepiness: Int
    @NSManaged public var lives: Int
    @NSManaged public var creationDate: Date

}

extension CharacterModel : Identifiable {

}
