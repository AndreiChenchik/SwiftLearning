//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Andrei Chenchik on 18/6/21.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }
    
    var wrapedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
