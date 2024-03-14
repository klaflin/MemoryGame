//
//  MemorizeGame.swift
//  MemoryGame
//
//  Created by KELLIE LAFLIN on 3/11/24.
//

import Foundation

///  ** THE MODEL **
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> //private(set) allows view only external access to cards
    
    var score: Int {
        get{
            cards.indices.filter{index in cards[index].isMatched}.count - 
            cards.indices.map{cards[$0].hits == 0 ? 0 : cards[$0].hits - 1}.reduce(0, +)
        }
    }
    
    private var indexOfSingleFaceUpCard: Int? {
        get { cards.indices.filter{index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    } //should only have max 1 card face up; we try to "match" this card
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        //now we need to add number of pairs of cards x2 cards
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex) //we don't know what the content is, so we use the function to fetch it
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
        shuffle()
    }
    
    /// What happens when a player taps on a card?
    mutating func choose(_ card: Card) -> Void {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfSingleFaceUpCard {
                    //we have one card face up
                    if cards[potentialMatchIndex].content == cards[chosenIndex].content {
                        //the cards match!
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    } else {
                        //we have seen these cards both in an unmatched pair
                        cards[chosenIndex].hits += 1
                        cards[potentialMatchIndex].hits += 1
                        
                    }
                } else {
                    //no or two cards are face up
                    indexOfSingleFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    
    ///Shuffles the order of the `cards` in the MemoryGame.
    mutating func shuffle(){
        cards.shuffle()
    }
    
    
    /// A single card in the MemoryGame
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var hits = 0
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
    
}

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
}
