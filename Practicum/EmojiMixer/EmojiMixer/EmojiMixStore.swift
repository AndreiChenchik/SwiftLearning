import CoreData
import UIKit

final class EmojiMixStore {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    convenience init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Something went terribly wrong")
        }

        let context = appDelegate.persistentContainer.viewContext

        self.init(context: context)
    }


    func addNewEmojiMix(_ emojiMix: EmojiMix) throws {
        let newMix = EmojiMixCoreData(context: context)
        newMix.emojies = emojiMix.emojies
        newMix.colorHex = emojiMix.backgroundColor.hexString

        try context.save()
    }

    func fetchEmojiMixes() throws -> [EmojiMix] {
        let request = EmojiMixCoreData.fetchRequest()
        request.returnsObjectsAsFaults = false

        let emojis = try context.fetch(request)

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
