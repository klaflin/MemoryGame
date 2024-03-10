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
    var isFaceUp: Bool = false;
    
    var body: some View {
        ZStack{
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2)
                Text("Card").font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}
