//
//  CoreDataRepository.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 16.04.2024.
//

import CoreData

protocol Repository {
    func fetch<ResultType>(request: NSFetchRequest<ResultType>) -> [ResultType] where ResultType : NSFetchRequestResult
    func delete(_ object: NSManagedObject)
    @discardableResult
    func save() -> Bool
}

final class CoreDataRepository: Repository {
    private let context = CoreDataManager.shared.context
    
    func fetch<ResultType>(request: NSFetchRequest<ResultType>) -> [ResultType] where ResultType : NSFetchRequestResult {
        var data = [ResultType]()
        if let savedData = try? context.fetch(request) {
            data = savedData
        } else {
            print("No saved data")
        }
        
        return data
    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    @discardableResult
    func save() -> Bool {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error CoreData: Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
        }
        return true
    }
}
