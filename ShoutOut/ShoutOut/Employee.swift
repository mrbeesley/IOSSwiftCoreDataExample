//
//  Employee.swift
//  ShoutOut
//
//  Created by mbeesley on 8/14/17.
//  Copyright © 2017 pluralsight. All rights reserved.
//

import Foundation
import CoreData

class Employee: NSManagedObject {
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    
    @NSManaged var shoutOuts: NSSet?
}
