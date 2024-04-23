//
//  Concentration.swift
//  ZenUI
//
//  Created by David on 02.04.2024.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var content: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

class GameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    
    init() {
        resetGame()
    }
    
    func resetGame() {
        let contents = ["👻", "🎃", "🕷", "👻", "🎃", "🕷"]
        cards = contents.shuffled().enumerated().map { index, content in
            Card(content: content)
        }
    }
    
    func choose(_ card: Card) {
        if let selectedIdx = cards.firstIndex(where: { $0.id == card.id }),
           !cards[selectedIdx].isFaceUp,
           !cards[selectedIdx].isMatched {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            cards[selectedIdx].isFaceUp = true
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard,
               potentialMatchIndex != selectedIdx {
                if cards[potentialMatchIndex].content == cards[selectedIdx].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[selectedIdx].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                indexOfTheOneAndOnlyFaceUpCard = selectedIdx
            }
        }
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
}

public struct ConcentrationContentView: View {
    public init() { }
    
    @ObservedObject var viewModel = GameViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())] // Configuring columns for the grid

    public var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding()
            
            Button {
                viewModel.resetGame()
            } label: {
                Text("Restart Game")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .background(Color("brandPrimary"))
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp || card.isMatched {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(card.isMatched ? Color.green : Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: 10).fill(Color.gray)
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.75))
        }
    }
}

struct ConcentrationContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentrationContentView()
    }
}
