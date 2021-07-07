//
//  Roll+CoreDataProperties.swift
//  DiceRoller
//
//  Created by Andrei Chenchik on 7/7/21.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var date: Date?
    @NSManaged public var result: Int16
    @NSManaged public var sides: Int16

}

extension Roll : Identifiable {

}
