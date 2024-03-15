//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/11/24.
//

import SwiftUI

/// **VIEW MODEL**
class EmojiMemoryGame: ObservableObject { //
    //static = "global" variables (Type variables)
    private static func createMemoryGame(_ emojis: [String], _ numberOfPairs: Int) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: numberOfPairs){pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            } else {
                return "⁉️⁉️"
            }
            
        }
    }
    
    @Published private var game : MemoryGame<String>//model
    // @Published will tell us "if this var changes, tell us something changed"
    private var theme : MemoryGameTheme 
    
    init() {
        theme = MemoryGameTheme(Themes.allCases.randomElement() ?? Themes.animals, Int.random(in: 4...10)) //FIXME: random number generation?
        game = EmojiMemoryGame.createMemoryGame(theme.emojis, theme.numberOfPairs)
    }
    
    //MARK: - COMPUTED VARS
    var cards: Array<MemoryGame<String>.Card> { game.cards }
    
    var themeColor: Color {
        switch theme.themeColor {
        case "Orange": .orange
        case "Purple": .purple
        case "Red": .red
        case "Yellow": .yellow
        case "Brown": .brown
        default: .black
        }
    }
    
    var themeName: Themes { theme.name }
    
    var score: Int { game.score }
    
    var haveWon: Bool {game.gameWon}
    
    //MARK: - Intents
    
    //intent function
    func choose(_ card: MemoryGame<String>.Card) {
        //print("chose that card \(card)")
        game.choose(card)
    }
    
    //intent function
    func shuffle(){
        game.shuffle()
    }
    
    func newGame(){
        theme = MemoryGameTheme(Themes.allCases.randomElement() ?? Themes.animals, Int.random(in: 4...10)) //FIXME: random number generation?
        game = EmojiMemoryGame.createMemoryGame(theme.emojis, theme.numberOfPairs)
    }
}
