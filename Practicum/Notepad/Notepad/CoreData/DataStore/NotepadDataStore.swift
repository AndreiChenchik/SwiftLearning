import CoreData

protocol NotepadDataStore {
    var managedObjectContext: NSManagedObjectContext? { get }
    func add(_ record: NotepadRecord) throws
    func delete(_ record: NSManagedObject) throws
}
