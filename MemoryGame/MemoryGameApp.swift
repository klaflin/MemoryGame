//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/5/24.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    @StateObject var game = EmojiMemoryGame()
    //you set your state at the app level & pass it in to the view model
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
