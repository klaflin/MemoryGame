//
//  ContentView.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/5/24.
//

import SwiftUI

let halloweenEmojis = ["👻", "🎃", "🕷️", "💀", "🧙", "🍬", "🍫", "🐈‍⬛"]
let christmasEmojis = ["🎄", "🎅", "🧑‍🎄", "🎁", "🧑‍🎄", "🎊", "🍗"]
let animalEmojis = ["🐱", "🐶", "🐰", "🐭", "🐨", "🐷", "🐮", "🦄", "🐼"]

struct ContentView: View {

    @State var emojis = halloweenEmojis
    @State var cardColor: Color = .orange
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.title)
            ScrollView{
                cards
            }
            Spacer()
            HStack(){
                halloweenButton
                animalButton
                christmasButton
            }
        }
        .padding()
    }
    
    
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            
            ForEach(0..<cardCount, id: \.self){index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardColor)
    }
    
    func makeThemeButton(title: String, emojiSet: [String], newColor: Color) -> some View {
        Button(action: {
            emojis = emojiSet
            cardColor = newColor
        }, label: {
            Text(title)
        })
        .buttonStyle(.bordered)
        .disabled(emojis == emojiSet)
        
    }
    
    var halloweenButton: some View {
        return makeThemeButton(title: "Halloween Theme", emojiSet: halloweenEmojis, newColor: .orange)
    }
    
    var christmasButton: some View {
        return makeThemeButton(title: "Christmas Theme", emojiSet: christmasEmojis, newColor: .green)
    }
    
    var animalButton: some View {
        return makeThemeButton(title: "Animal Theme", emojiSet: animalEmojis, newColor: .brown)
    }
     
}

#Preview {
    ContentView()
}


struct CardView: View {
    @State var isFaceUp = false;
    let content : String;
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 100)
        }.onTapGesture{
            isFaceUp.toggle()
        }
    }
}
