//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/5/24.
//

import SwiftUI

///**VIEW**
struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame //view model, NEVER hard code it here
    //@ObservedObject says "if this var says something changed, redraw me!"
    //should NEVER be set using an =
    
    
    var body: some View {
        VStack{
            Text("Memorize \(game.themeName)!")
                .font(.title)
                .foregroundStyle(game.themeColor)
            Text("Your score: \(game.score)")
            ScrollView{
                cards
                    .animation(.default, value: game.cards)
            }
            Button("New Game"){
                game.newGame()
            }
        }
        .padding()
    }
    
    
    var cards : some View {
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            
            ForEach(game.cards){card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture{
                        game.choose(card)
                    }
            }
        }
        .foregroundColor(game.themeColor)
    }
}

struct CardView: View {
    let card : MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 100)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(game: EmojiMemoryGame())
}
