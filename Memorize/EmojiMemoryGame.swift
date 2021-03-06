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
    private static let cars =  ["๐","๐ ", "๐", "๐",  "โ๏ธ", "๐ฉ",  "๐", "๐ป", "๐", "๐", "๐บ", "๐", "๐"]
    private static let hearts = ["๐","โค๏ธ", "๐", "๐งก", "๐", "๐", "๐", "๐", "๐ค", "๐ค", "๐ค", "๐", "โค๏ธโ๐ฅ"]
    private static let flags = ["๐ฌ๐น", "๐ฎ๐ช", "๐ฒ๐จ", "๐ฒ๐ณ", "๐ฒ๐ช", "๐ฒ๐ธ", "๐ฒ๐ฆ", "๐ฒ๐ฟ", "๐ฒ๐ฒ", "๐ณ๐ฆ", "๐ณ๐ท", "๐ณ๐ต"]
    private static let symbols = ["๐", "๐", "๐", "๐", "โญ๏ธ", "๐ข", "โจ๏ธ", "๐ท"]
    private static let foods = ["๐","๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐", "๐ซ"]
    private static let activity = ["โฝ๏ธ", "๐", "๐", "โพ๏ธ", "๐ฅ", "๐พ", "๐", "๐", "โท", "๐"]

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
