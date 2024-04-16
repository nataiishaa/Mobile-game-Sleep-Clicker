//
//  CoreDataManager.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 15.04.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SleepMobApp")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    private init() {}
    
    func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    @discardableResult
    static func save(context: NSManagedObjectContext) -> Bool {
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
