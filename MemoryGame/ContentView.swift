//
//  ContentView.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}


struct CardView: View {
    @State var isFaceUp = false;
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("Card").font(.largeTitle)
            }
            else {
                base
            }
        }.onTapGesture{
            isFaceUp.toggle()
        }
    }
}
