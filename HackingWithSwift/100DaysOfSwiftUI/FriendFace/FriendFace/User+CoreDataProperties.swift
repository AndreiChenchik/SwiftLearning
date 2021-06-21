//
//  User+CoreDataProperties.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//
//

import Foundation
import CoreData


extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var externalId:   String?
    @NSManaged public var age:          Int16
    @NSManaged public var name:         String?
    @NSManaged public var company:      String?
    @NSManaged public var email:        String?
    @NSManaged public var address:      String?
    @NSManaged public var about:        String?
    @NSManaged public var registered:   String?
    @NSManaged public var tags:         String?
    @NSManaged public var isActive:     Bool
    @NSManaged public var friends:      NSSet?
    
    var wrappedExternalId:  String  { externalId    ?? "Unknown ID" }
    var wrappedName:        String  { name          ?? "Unknown Name" }
    var wrappedCompany:     String  { company       ?? "Unknown Company" }
    var wrappedEmail:       String  { email         ?? "Unknown email" }
    var wrappedAddress:     String  { address       ?? "Unknown Address" }
    var wrappedAbout:       String  { about         ?? "N/A" }
    var wrappedTags:        String  { tags          ?? "N/A" }
    
    var friendsArray: [User] {
        let friends = friends as? Set<User> ?? []
        
        return friends.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    var formattedRegisteredDate: String {
        guard let registered = registered else { return "N/A"}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxx"
        if let date = formatter.date(from: registered) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        } else {
            return registered
        }
    }
}

// MARK: Generated accessors for friends
extension User {
    
    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: User)
    
    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: User)
    
    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)
    
    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)
    
}

extension User : Identifiable {
    
}
