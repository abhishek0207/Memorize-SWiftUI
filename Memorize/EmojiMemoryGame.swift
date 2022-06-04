//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ahuja, Abhishek on 5/29/22.
//

import SwiftUI



enum Themes : CaseIterable {
   case symbols
   case flags
   case cars
   case food
   case activity
   case hearts
}

class EmojiMemoryGame : ObservableObject{
    private static let cars =  ["🚗","🚠", "🚔", "🏎",  "✈️", "🛩",  "🚐", "🛻", "🚚", "🚜", "🛺", "🛞", "🚘"]
    private static let hearts = ["😍","❤️", "💘", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔", "❤️‍🔥"]
    private static let flags = ["🇬🇹", "🇮🇪", "🇲🇨", "🇲🇳", "🇲🇪", "🇲🇸", "🇲🇦", "🇲🇿", "🇲🇲", "🇳🇦", "🇳🇷", "🇳🇵"]
    private static let symbols = ["💟", "🉑", "🉐", "🆎", "⭕️", "💢", "♨️", "🚷"]
    private static let foods = ["🍏","🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐"]
    private static let activity = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏑", "⛷", "🏂"]

    static func getRandomTheme(selectedTheme : Themes) -> MemoryGame<String>.Theme {
        switch selectedTheme {
        case .symbols:
            return MemoryGame<String>.Theme(name: "symbols", emojis: symbols.shuffled(), fillColor: .orange )
        case .flags:
            return MemoryGame<String>.Theme(name: "flags", emojis: flags.shuffled(),fillColor: .blue )
        case .cars:
            return MemoryGame<String>.Theme(name: "cars", emojis: cars.shuffled(), numberOfPairsOfCards: 6, fillColor: .cyan)
        case .food:
            return MemoryGame<String>.Theme(name: "foods", emojis: foods.shuffled(), numberOfPairsOfCards: 8, fillColor: .mint)
        case .activity:
            return MemoryGame<String>.Theme(name: "activity", emojis: activity.shuffled(), numberOfPairsOfCards: 3, fillColor: .purple )
        case .hearts:
            return MemoryGame<String>.Theme(name: "hearts", emojis: hearts.shuffled(), numberOfPairsOfCards: 2, fillColor: .teal )
        }

    }
    static func createMemoryGame() -> MemoryGame<String> {
        let theme : MemoryGame<String>.Theme  = getRandomTheme(selectedTheme: Themes.allCases.randomElement()!)
        return MemoryGame<String>(theme: theme) { index in theme.emojis[index]} // we hide the model from any views accessing the model directly
    }
    @Published private var model : MemoryGame<String> = createMemoryGame()
    var cards : Array<MemoryGame<String>.Card> {
        model.cards // because this value is computed from the other property, we set this as a computed property
    }
    func choose(_ card : MemoryGame<String>.Card)  {
        self.model.choose(card)
    }
    func currentTheme() -> MemoryGame<String>.Theme {
        return self.model.theme
    }
   func restartGame() {
       model = EmojiMemoryGame.createMemoryGame()
    }
    func getScore() -> Int {
        return model.score
    }
}
