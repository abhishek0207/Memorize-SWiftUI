//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ahuja, Abhishek on 5/29/22.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent : Equatable {
    private(set) var cards : [Card]
    private var alreadyChosenaCard : Int?
    var theme: Theme
    var score : Int = 0
    var seen : [Int] = []
    
    mutating func choose(_ card: Card) {
        //here we add a "_" because our type already specifies what we need to pass. the argument label card is kinda redundant.
        let firstIndex : Int? = cards.firstIndex { Card in
            Card.id == card.id
        }
        if let firstIndex = firstIndex, !cards[firstIndex].isFaceUp {
            print(cards[firstIndex])
            print(alreadyChosenaCard ?? "Not chosen yet")
            if let alreadyChosenaCard = alreadyChosenaCard {
                if cards[alreadyChosenaCard].content == cards[firstIndex].content {
                    cards[alreadyChosenaCard].isMatched = true
                    cards[firstIndex].isMatched = true
                    score+=2
                } else {
                    let alreadyChosenaCardId = cards[alreadyChosenaCard].id
                    let firstIndexCardId = cards[firstIndex].id
                    if seen.contains(alreadyChosenaCardId) {
                        score-=1
                    } else {
                        seen.append(alreadyChosenaCardId)
                    }
                    if seen.contains(firstIndexCardId) {
                        score-=1
                    } else {
                        seen.append(firstIndexCardId)
                    }
                }
                self.alreadyChosenaCard = nil
            } else {
                 cards.indices.filter {!cards[$0].isMatched}
                    .forEach { cards[$0].isFaceUp  = false }
                alreadyChosenaCard = firstIndex
            }
           cards[firstIndex].isFaceUp.toggle()
        }
    }
    init(theme: Theme, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<theme.numberOfPairsOfCards {
            // We delegated the responsibility of creating the cards to the viewModel
            if pairIndex < theme.emojis.count {
            cards.append(Card(content: createCardContent(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: createCardContent(pairIndex), id: (pairIndex * 2) + 1))
            }
        }
        cards = cards.shuffled()
        self.theme = theme
    }
    struct Card : Identifiable{
        var isFaceUp : Bool = false
        var isMatched: Bool = false
        var content : CardContent
        var id: Int
    }
    struct Theme {
        var name: String
        var emojis: Array<String>
        var numberOfPairsOfCards: Int = 4
        var fillColor : Color = .red
    }
}
