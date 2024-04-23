//
//  TicTacToe.swift
//  ZenUI
//
//  Created by David on 06.04.2024.
//

import SwiftUI

public struct TicTacToeContentView: View {
    public init() { }
    
    let boardSize = 3
    let robotPlayer = "O"
    let humanPlayer = "X"
    
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State private var isHumanTurn = true
    @State private var isGameOver = false
    @State private var winner = ""
    
    public var body: some View {
        VStack(spacing: 15) {
            
            ForEach(0..<boardSize, id: \.self) { row in
                HStack {
                    ForEach(0..<boardSize, id: \.self) { col in
                        Button(action: {
                            processTurn(row: row, col: col)
                        }) {
                            Text(board[row][col])
                                .font(.system(size: 56))
                                .frame(width: 100, height: 100)
                                .background(isGameOver ? Color.gray : Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }
                    }
                }
            }
            
            if isGameOver {
                Text(winner.isEmpty ? "Draw" : "\(winner) wins!")
                    .font(.title)
                    .padding()
            }

            
            Button {
                restartGame()
            } label: {
                Text("Restart")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 280, height: 50)
                    .foregroundColor(.white)
                    .background(Color("brandSecondary"))
                    .cornerRadius(10)
            }
            .padding()

            
            Spacer()
        }
        .padding()
    }

    func processTurn(row: Int, col: Int) {
        guard board[row][col].isEmpty, !isGameOver else { return }
        
        board[row][col] = humanPlayer
        isHumanTurn.toggle()
        
        if checkWin(player: humanPlayer) {
            winner = humanPlayer
            isGameOver = true
        } else if checkDraw() {
            isGameOver = true
        } else {
            robotTurn()
        }
    }
    
    func restartGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        isGameOver = false
        isHumanTurn = true
        winner = ""
    }
    
    func checkWin(player: String) -> Bool {
        for i in 0..<boardSize {
            if board[i][0] == player && board[i][1] == player && board[i][2] == player {
                return true
            }
            
            if board[0][i] == player && board[1][i] == player && board[2][i] == player {
                return true
            }
        }
        
        if board[0][0] == player && board[1][1] == player && board[2][2] == player {
            return true
        }
        
        if board[0][2] == player && board[1][1] == player && board[2][0] == player {
            return true
        }
        
        return false
    }
    
    func checkDraw() -> Bool {
        for row in board {
            for cell in row {
                if cell.isEmpty {
                    return false
                }
            }
        }
        return true
    }
    
    func minmax(depth: Int, isMaximizing: Bool) -> Int {
        if checkWin(player: robotPlayer) {
            return 10 - depth
        } else if checkWin(player: humanPlayer) {
            return depth - 10
        } else if checkDraw() {
            return 0
        }
        
        var bestScore = 0
        
        if isMaximizing {
            bestScore = Int.min
            
            for i in 0..<boardSize {
                for j in 0..<boardSize {
                    if board[i][j].isEmpty {
                        board[i][j] = robotPlayer
                        let score = minmax(depth: depth + 1, isMaximizing: false)
                        board[i][j] = ""
                        bestScore = max(score, bestScore)
                    }
                }
            }
        } else {
            bestScore = Int.max
            
            for i in 0..<boardSize {
                for j in 0..<boardSize {
                    if board[i][j].isEmpty {
                        board[i][j] = humanPlayer
                        let score = minmax(depth: depth + 1, isMaximizing: true)
                        board[i][j] = ""
                        bestScore = min(score, bestScore)
                    }
                }
            }
        }
        
        return bestScore
    }
    
    func robotTurn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            var bestScore = Int.min
            var bestMove = (-1, -1)
            
            for i in 0..<boardSize {
                for j in 0..<boardSize {
                    if board[i][j].isEmpty {
                        board[i][j] = robotPlayer
                        let score = minmax(depth: 0, isMaximizing: false)
                        board[i][j] = ""
                        
                        if score > bestScore {
                            bestScore = score
                            bestMove = (i, j)
                        }
                    }
                }
            }
            
            board[bestMove.0][bestMove.1] = robotPlayer
            isHumanTurn.toggle()
            
            if checkWin(player: robotPlayer) {
                winner = robotPlayer
                isGameOver = true
            } else if checkDraw() {
                isGameOver = true
            }
        }
    }
}

struct TicTacToeContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeContentView()
    }
}
