//
//  ShoutOut.swift
//  ShoutOut
//
//  Created by mbeesley on 8/11/17.
//  Copyright © 2017 pluralsight. All rights reserved.
//

import Foundation
import CoreData

class ShoutOut: NSManagedObject {
    @NSManaged var from: String?
    @NSManaged var message: String?
    @NSManaged var sentOn: Date?
    @NSManaged var shoutCategory: String
    
    @NSManaged var toEmployee: Employee
    
    static var entityName: String { return "ShoutOut" }
}
