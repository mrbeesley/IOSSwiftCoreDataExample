//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by mbeesley on 8/10/17.
//  Copyright © 2017 pluralsight. All rights reserved.
//

import Foundation
import CoreData

func createMainContext(completion: @escaping (NSPersistentContainer) -> Void) {
    
    let container = NSPersistentContainer(name: "ShoutOut")
    
    let storeUrl = URL.documentsURL.appendingPathComponent("ShoutOut.sqlite")
    let storeDescription = NSPersistentStoreDescription(url: storeUrl)
    container.persistentStoreDescriptions = [storeDescription]
    
    container.loadPersistentStores(completionHandler: {
        persistentStoreDesciption, error in
        
        guard error == nil else { fatalError("Failed to load data store: \(error)") }
        
        DispatchQueue.main.async {
            completion(container)
        }
        
    })
    
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
