//
//  DataService.swift
//  ShoutOut
//
//  Created by mbeesley on 8/15/17.
//  Copyright © 2017 pluralsight. All rights reserved.
//

import Foundation
import CoreData

struct DataService: ManagedObjectContextDependentType {
    
    var managedObjectContext: NSManagedObjectContext!
    
    func seedEmployees(){
        
        let employee1 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee
        employee1.firstName = "Jane"
        employee1.lastName = "Sherman"
        
        let employee2 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee
        employee2.firstName = "Luke"
        employee2.lastName = "Jones"
        
        let employee3 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee
        employee3.firstName = "Kathy"
        employee3.lastName = "Smith"
        
        let employee4 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee
        employee4.firstName = "Jerome"
        employee4.lastName = "Rodriguez"
        
        let employee5 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee
        employee5.firstName = "Maria"
        employee5.lastName = "Tillman"
        
        let employee6 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee
        employee6.firstName = "Paul"
        employee6.lastName = "O'Brian"
        
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Something went wrong when saving the employee into the managedObjectContext: \(error)")
            self.managedObjectContext.rollback()
        }
        
    }
}
