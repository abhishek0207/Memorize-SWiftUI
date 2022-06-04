//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ahuja, Abhishek on 5/27/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
