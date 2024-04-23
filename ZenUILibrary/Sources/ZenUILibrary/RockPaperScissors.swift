//
//  RockPaperScissors.swift
//  ZenUI
//
//  Created by David on 04.04.2024.
//

import SwiftUI

public struct RockPaperScissorsContentView: View {
    public init() { }
    
    @State private var playerChoice = ""
    @State private var computerChoice = ""
    @State private var resultMessage = ""
    @State private var wins = 0
    @State private var losses = 0
    @State private var draws = 0
    
    let choices = ["Rock", "Paper", "Scissors"]
    
    public var body: some View {
        VStack(spacing: 20) {
            // Display the score
            HStack {
                Spacer()
                VStack {
                    Text("Wins: \(wins)")
                    Text("Losses: \(losses)")
                    Text("Draws: \(draws)")
                }
                .font(.title)
                .padding()
                Spacer()
            }
            
            Spacer()
            
            // Display the game result and computer's choice
            VStack {
                Image(computerChoice) // Display image based on computer's choice
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text(resultMessage)
                    .font(.largeTitle)
            }
            
            Spacer()
            
            // Player choices
            HStack {
                ForEach(choices, id: \.self) { choice in
                    Button(action: {
                        self.playGame(playerChoice: choice)
                    }) {
                        Text(choice)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 150, maxHeight: 100) // Ensures equal width for all buttons
                            .background(Color("brandSecondary"))
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .padding()
    }
    
    func playGame(playerChoice: String) {
        self.playerChoice = playerChoice
        computerChoice = choices.randomElement() ?? "Rock"
        
        let result = determineWinner(playerChoice: playerChoice, computerChoice: computerChoice)
        updateScore(with: result)
        resultMessage = result.message
    }
    
    func determineWinner(playerChoice: String, computerChoice: String) -> GameResult {
        if playerChoice == computerChoice {
            return .draw
        }
        
        switch (playerChoice, computerChoice) {
        case ("Rock", "Scissors"), ("Paper", "Rock"), ("Scissors", "Paper"):
            return .win
        default:
            return .loss
        }
    }
    
    func updateScore(with result: GameResult) {
        switch result {
        case .win:
            wins += 1
        case .loss:
            losses += 1
        case .draw:
            draws += 1
        }
    }
}

enum GameResult {
    case win, loss, draw
    
    var message: String {
        switch self {
        case .win:
            return "You Win!"
        case .loss:
            return "You Lose!"
        case .draw:
            return "It's a Draw!"
        }
    }
}

struct RockPaperScissorsContentView_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissorsContentView()
    }
}
