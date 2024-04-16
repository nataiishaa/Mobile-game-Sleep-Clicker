//
//  BedroomWorker.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 16.04.2024.
//

import CoreData

final class BedroomWorker: BedroomWorkingLogic {
    private let repository: Repository
    
    init(repository: Repository = CoreDataRepository()) {
        self.repository = repository
    }
    
    func getCharacters() -> [CharacterModel] {
        
        let fetchRequest = NSFetchRequest<CharacterModel>(entityName: "CharacterModel")
        
        return repository.fetch(request: fetchRequest)
    }
    
    func getBoosts(type: BoostType? = nil) -> [BoostModel] {
       
        
        let fetchRequest = NSFetchRequest<BoostModel>(entityName: "BoostModel")
        var predicates = [NSPredicate]()
        
        if let type {
            let predicate = NSPredicate(format: "rawBoostType == %@", argumentArray: [type.rawValue])
            predicates.append(predicate)
        }
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        fetchRequest.predicate = compoundPredicate
        
        return repository.fetch(request: fetchRequest)
    }
    
    func delete(_ object: NSManagedObject) {
        delete(object, save: true)
    }
    
    func delete(_ object: NSManagedObject, save: Bool) {
        repository.delete(object)
        if save {
            repository.save()
        }
    }
    
    func save() {
        repository.save()
    }
}
