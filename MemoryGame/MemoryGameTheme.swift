//
//  MemoryGameTheme.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/13/24.
//

import Foundation

/// **MODEL**
struct MemoryGameTheme {
    let name: Themes
    let emojis: [String]
    let themeColor: String
    let numberOfPairs: Int
    
    init(_ themeName: Themes, _ numPairs: Int) {
        self.name = themeName
        let e: [String]
        switch name {
        case .food:
            e = ["🍎", "🍌", "🍖", "🍛", "🥟", "🍬", "🍫", "🍉"]
            themeColor = "Brown"
        case .fashion:
            e = [ "👚", "👖", "👘", "🧦", "👗", "🧣"]
            themeColor = "Purple"
        case .animals:
            e = ["🐱", "🐶", "🐰", "🐭", "🐨", "🐷", "🐮", "🐼"]
            themeColor = "Red"
        case .spooky:
            e = ["🎃","👻","💀","🕷️","🕸️","👹","👹","🙀", "🍭"]
            themeColor = "Orange"
        case .people:
            e = ["😃","😂","🥰","🤩","🥳","😡","😎","🤯","🫡","🫣"]
            themeColor = "Yellow"
        case .hands:
            e = ["🫶","🙌","👍","👎","🤝","✌️","🤙","🖕","🤌"]
            themeColor = "Yellow"
        }
        emojis = e.shuffled()
        numberOfPairs = min(numPairs, emojis.count)
    }
}

enum Themes : CaseIterable {
    case food
    case fashion
    case animals
    case spooky
    case people
    case hands
}
