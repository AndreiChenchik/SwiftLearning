import CoreData

final class NullStore {}

extension NullStore: NotepadDataStore {
    var managedObjectContext: NSManagedObjectContext? { nil }
    func add(_ record: NotepadRecord) throws {}
    func delete(_ record: NSManagedObject) throws {}
}
