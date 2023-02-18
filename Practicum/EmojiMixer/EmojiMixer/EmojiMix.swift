import UIKit

struct EmojiMix {
    let emojies: String
    let backgroundColor: UIColor
}

extension EmojiMix {
    static var allEmojies: [String]  {
        [
            "🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒",
            "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️",
            "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"
        ]
    }

    static var newMix: EmojiMix {
        let first = Int.random(in: 0..<allEmojies.count)
        let second = Int.random(in: 0..<allEmojies.count)
        let third = Int.random(in: 0..<allEmojies.count)

        let emojies = allEmojies[first] + allEmojies[second] + allEmojies[third]

        let hue = CGFloat(first + second + third) / (3 * CGFloat(allEmojies.count))

        return .init(emojies: emojies, backgroundColor: .init(hue: hue,
                                                              saturation: 0.2,
                                                              brightness: 0.95,
                                                              alpha: 1))
    }
}
