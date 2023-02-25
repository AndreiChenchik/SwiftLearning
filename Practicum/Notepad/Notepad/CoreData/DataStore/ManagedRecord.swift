import CoreData

@objc(ManagedRecord)
class ManagedRecord: NSManagedObject, NotepadRecord {
    @NSManaged var id: UUID
    @NSManaged var title: String
    @NSManaged var body: String
    @NSManaged var createdAt: Date
}
