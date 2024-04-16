//
//  FetchRequester.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 15.04.2024.
//

import Foundation
import CoreData

struct FetchRequester{
    static func getCharacters(context: NSManagedObjectContext) -> [CharacterModel] {
        var data = [CharacterModel]()
        
        let fetchRequest = NSFetchRequest<CharacterModel>(entityName: "CharacterModel")
        
        if let savedData = try? context.fetch(fetchRequest) {
            data = savedData
        } else {
            print("No saved data")
        }
        
        return data
    }
    
    static func getBoosts(context: NSManagedObjectContext, type: BoostType? = nil) -> [BoostModel] {
        var data = [BoostModel]()
        
        let fetchRequest = NSFetchRequest<BoostModel>(entityName: "BoostModel")
        var predicates = [NSPredicate]()
        
        if let type {
            let predicate = NSPredicate(format: "rawBoostType == %@", argumentArray: [type.rawValue])
            predicates.append(predicate)
        }
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        fetchRequest.predicate = compoundPredicate
        
        if let savedData = try? context.fetch(fetchRequest) {
            data = savedData
        } else {
            print("No saved data")
        }
        
        return data
    }
}
