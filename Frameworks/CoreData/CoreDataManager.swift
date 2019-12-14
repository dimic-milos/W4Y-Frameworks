//
//  CoreDataManager.swift
//  Frameworks
//
//  Created by Dimic Milos on 12/14/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    class PersistentContainer: NSPersistentContainer {}
    
    struct Constants {
        static let PersistentContainerName = "FrameworksModel"
    }
    
    enum Entity: String {
        case CoreDataUser = "CoreDataUser"
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = PersistentContainer(name: Constants.PersistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CoreData User
    
    func createUser(subscription: String?, id : UUID, entity: Entity) -> CoreDataUser? {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entity.rawValue, in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        user.setValue(subscription, forKeyPath: "subscription")
        user.setValue(id, forKeyPath: "id")
        
        do {
            try managedContext.save()
            return user as? CoreDataUser
        } catch {
            fatalError()
        }
    }
    
    func readAllUsers() -> [CoreDataUser]? {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entity.CoreDataUser.rawValue)
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            return users as? [CoreDataUser]
        } catch {
            fatalError()
        }
    }
    
    // MARK: - Destructive
    
    func deleteAllObjects(inEntity entity: Entity) {

        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }
            try managedContext.save()
        } catch {
            fatalError()
        }
    }

}
