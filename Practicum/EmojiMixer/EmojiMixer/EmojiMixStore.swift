import CoreData
import UIKit

struct StoreUpdate {
    let insertedIndexes: IndexSet
    let deletedIndexes: IndexSet
}

protocol EmojiMixStoreDelegate: AnyObject {
    func didUpdate(_ update: StoreUpdate)
}

final class EmojiMixStore: NSObject {
    let context: NSManagedObjectContext
    weak var delegate: EmojiMixStoreDelegate?
    private lazy var fetchedResultsController: NSFetchedResultsController<EmojiMixCoreData> = {

        let fetchRequest = EmojiMixCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: context,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)

        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }()

    private var insertedIndexes: IndexSet?
    private var deletedIndexes: IndexSet?

    init(context: NSManagedObjectContext, delegate: EmojiMixStoreDelegate? = nil) {
        self.delegate = delegate

        self.context = context
    }

    convenience init(delegate: EmojiMixStoreDelegate? = nil) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Something went terribly wrong")
        }

        let context = appDelegate.persistentContainer.viewContext

        self.init(context: context, delegate: delegate)
    }


    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        let newMix = EmojiMixCoreData(context: context)
        newMix.emojies = emojiMix.emojies
        newMix.colorHex = emojiMix.backgroundColor.hexString
        newMix.createdAt = Date()

        try context.save()
    }

    func fetchEmojiMixes() throws -> [EmojiMix] {
        guard let emojis = fetchedResultsController.fetchedObjects else { return [] }

        return emojis.compactMap { coreDataModel in
            guard let emojies = coreDataModel.emojies,
                  let hex = coreDataModel.colorHex,
                  let uiColor = UIColor(hex: hex) else {
                return nil
            }

            return.init(emojies: emojies, backgroundColor: uiColor)
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension EmojiMixStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        insertedIndexes = IndexSet()
        deletedIndexes = IndexSet()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdate(StoreUpdate(
                insertedIndexes: insertedIndexes!,
                deletedIndexes: deletedIndexes!
            )
        )
        insertedIndexes = nil
        deletedIndexes = nil
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .delete:
            if let indexPath = indexPath {
                deletedIndexes?.insert(indexPath.item)
            }
        case .insert:
            if let indexPath = newIndexPath {
                insertedIndexes?.insert(indexPath.item)
            }
        default:
            break
        }
    }
}
