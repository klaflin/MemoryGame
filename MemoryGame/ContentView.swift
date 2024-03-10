//
//  ContentView.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/5/24.
//

import SwiftUI

let foodEmojis = ["🍎", "🍌", "🍖", "🍛", "🥟", "🍬", "🍫"]
let fashionEmojis = [ "👚", "👖", "👘", "🧦", "👗", "🧣"]
let animalEmojis = ["🐱", "🐶", "🐰", "🐭", "🐨", "🐷", "🐮", "🐼"]

struct ContentView: View {

    @State var emojis: [String] = []
    //@State var shuffledEmojis: [String] = []
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
                foodButton
                animalButton
                fashionButton
            }
        }
        .padding()
    }
    
    
    var cards : some View {
        let shuffledEmojis = (emojis + emojis).shuffled()
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            
            ForEach(0..<shuffledEmojis.count, id: \.self){index in
                CardView(content: shuffledEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardColor)
    }
    
    func makeThemeButton(icon: String, title: String, emojiSet: [String], newColor: Color) -> some View {
        Button(action: {
            emojis = emojiSet
            cardColor = newColor
        }, label: {
            VStack{
                Image(systemName: icon)
                Text(title)
            }
        })
        .buttonStyle(.bordered)
        .disabled(emojis == emojiSet)
        
    }
    
    var foodButton: some View {
        return makeThemeButton(icon: "takeoutbag.and.cup.and.straw.fill", title: "Food", emojiSet: foodEmojis, newColor: .red)
    }
    
    var animalButton: some View {
        return makeThemeButton(icon: "pawprint.fill", title: "Animals", emojiSet: animalEmojis, newColor: .brown)
    }
    
    var fashionButton: some View {
        return makeThemeButton(icon: "hanger", title: "Fashion", emojiSet: fashionEmojis, newColor: .purple)
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
