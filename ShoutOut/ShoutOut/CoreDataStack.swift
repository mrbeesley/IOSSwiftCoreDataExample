//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by mbeesley on 8/10/17.
//  Copyright © 2017 pluralsight. All rights reserved.
//

import Foundation
import CoreData

func createMainContext() -> NSManagedObjectContext {
    
    // Initialize NSManagedObjectModel
    let modelURL = Bundle.main.url(forResource: "ShoutOut", withExtension: "momd")
    guard let model = NSManagedObjectModel(contentsOf: modelURL!) else {
        fatalError("ShoutOut model not found at: \(String(describing: modelURL))")
    }
    
    
    // Configure NSPersistentStoreCoordinator with an NSPersistentStore
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    let storeUrl = try! URL.documentsURL.appendingPathComponent("ShoutOut.sqlite")
    
    //TODO: Add migrations! This should be removed before use!
    //try! FileManager.default.removeItem(at: storeUrl)
    
    // Add options for migrations
    let pscOptions = [
        NSMigratePersistentStoresAutomaticallyOption : true,
        NSInferMappingModelAutomaticallyOption : true
    ]
    
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: pscOptions)
    
    
    // Create and return NSManagedObjectContext
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    return context
    
}



extension URL {
    static var documentsURL: URL {
        return try! FileManager
            .default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}


protocol ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext! { get set }
}
