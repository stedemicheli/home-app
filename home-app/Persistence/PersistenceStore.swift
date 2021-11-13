//
//  Persistence.swift
//  home-app
//
//  Created by Stefano on 13.11.21.
//

import CoreData

protocol PersistenceStoreProtocol {

    func save(context: NSManagedObjectContext?) throws
    
    func fetch<Resource: NSManagedObject>(
        withId identifier: String,
        contractAddress: String,
        context: NSManagedObjectContext?
    ) throws -> Resource?
    
    func fetch<Resource: NSManagedObject>(
        recent fetchLimit: Int,
        in context: NSManagedObjectContext?
    ) throws -> [Resource]
    
    func delete<Resource: NSManagedObject>(
        _ object: Resource,
        in context: NSManagedObjectContext?
    )
    
    func deleteAll(in context: NSManagedObjectContext?) throws
    
    func reset(context: NSManagedObjectContext?)
}

final class PersistenceStore: PersistenceStoreProtocol {

    static let shared = PersistenceStore()

    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "home_app")
        container.loadPersistentStores  { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent store: \(error)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
        }

        return container
    }()

    var mainContext: NSManagedObjectContext { container.viewContext }

    func save(context: NSManagedObjectContext? = nil) throws {
        let context = context ?? mainContext
        var error: Error?
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                NSLog("Error while saving to persistent store: \(saveError)")
                error = saveError
            }
        }

        if let error = error { throw error }
    }

    func fetch<Resource: NSManagedObject>(
        withId identifier: String,
        contractAddress: String,
        context: NSManagedObjectContext? = nil
    ) throws -> Resource? {
        let context = context ?? mainContext
        var resource: Resource?
        var error: Error?
        guard let fetchRequest: NSFetchRequest<Resource> = Resource.fetchRequest() as? NSFetchRequest<Resource> else { throw PersistenceError.fetchRequestError }
        let idPredicate = NSPredicate(format: "identifier == %@", identifier)
        let predicate = NSCompoundPredicate(
            type: .and,
            subpredicates: [idPredicate]
        )
        fetchRequest.predicate = predicate

        context.performAndWait {
            do {
                resource = try context.fetch(fetchRequest).first
            } catch let fetchError {
                NSLog("Error loading from persistent store: \(fetchError)")
                error = fetchError
            }
        }

        if let error = error { throw error }

        return resource
    }

    func fetch<Resource: NSManagedObject>(
        recent fetchLimit: Int = 100,
        in context: NSManagedObjectContext? = nil
    ) throws -> [Resource] {
        let context = context ?? mainContext
        var resource = [Resource]()
        var error: Error?
        let entityName = String(describing: Resource.self)
        let fetchRequest = NSFetchRequest<Resource>(entityName: entityName)

        let timeSortDescriptor = NSSortDescriptor(key: "timestamp", ascending: true)
        fetchRequest.sortDescriptors = [timeSortDescriptor]
        fetchRequest.fetchLimit = fetchLimit

        context.performAndWait {
            do {
                resource = try context.fetch(fetchRequest)
            } catch let fetchError {
                NSLog("Error loading from persistent store: \(fetchError)")
                error = fetchError
            }
        }

        if let error = error { throw error }

        return resource
    }

    func delete<Resource: NSManagedObject>(
        _ object: Resource,
        in context: NSManagedObjectContext? = nil
    ) {
        let context = context ?? mainContext
        context.delete(object)
    }
    
    func deleteAll (
        in context: NSManagedObjectContext? = nil
    ) throws {
        let context = context ?? mainContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Home")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }

    func reset(context: NSManagedObjectContext? = nil) {
        let context = context ?? mainContext
        context.reset()
    }
}

enum PersistenceError: Error {
    case fetchRequestError
}
