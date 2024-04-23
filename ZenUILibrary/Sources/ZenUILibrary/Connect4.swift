//
//  Connect4.swift
//  ZenUI
//
//  Created by David on 22.04.2024.
//

import SwiftUI

enum Tile {
    case red, yellow, empty

    func tileColor() -> Color {
        switch self {
        case .red: return .red
        case .yellow: return .yellow
        case .empty: return .white
        }
    }
}

struct BoardItem {
    var tile: Tile = .empty
}

class GameBoard: ObservableObject {
    @Published var board: [[BoardItem]] = Array(repeating: Array(repeating: BoardItem(), count: 7), count: 6)
    @Published var currentPlayer: Tile = .red
    @Published var winner: Tile? = nil

    init() {
        resetBoard()
    }

    func resetBoard() {
        for row in 0..<6 {
            for column in 0..<7 {
                board[row][column] = BoardItem(tile: .empty)
            }
        }
        currentPlayer = .red
        winner = nil
    }

    func dropPiece(in column: Int) {
        if winner != nil { return }
        
        for row in (0..<6).reversed() {
            if board[row][column].tile == .empty {
                board[row][column].tile = currentPlayer
                if checkVictory(from: row, column: column) {
                    winner = currentPlayer
                }
                currentPlayer = currentPlayer == .yellow ? .red : .yellow
                break
            }
        }
    }

    func checkVictory(from row: Int, column: Int) -> Bool {
        return checkDirection(row: row, column: column, deltaRow: 0, deltaCol: 1) ||
               checkDirection(row: row, column: column, deltaRow: 1, deltaCol: 0) ||
               checkDirection(row: row, column: column, deltaRow: 1, deltaCol: 1) ||
               checkDirection(row: row, column: column, deltaRow: 1, deltaCol: -1)
    }

    func checkDirection(row: Int, column: Int, deltaRow: Int, deltaCol: Int) -> Bool {
        var count = 1
        count += countInDirection(row: row, column: column, deltaRow: deltaRow, deltaCol: deltaCol)
        count += countInDirection(row: row, column: column, deltaRow: -deltaRow, deltaCol: -deltaCol)
        return count >= 4
    }

    func countInDirection(row: Int, column: Int, deltaRow: Int, deltaCol: Int) -> Int {
        var currentRow = row + deltaRow
        var currentColumn = column + deltaCol
        var count = 0

        while currentRow >= 0 && currentRow < 6 && currentColumn >= 0 && currentColumn < 7 && board[currentRow][currentColumn].tile == currentPlayer {
            count += 1
            currentRow += deltaRow
            currentColumn += deltaCol
        }
        return count
    }
}

public struct ConnectFourContentView: View {
    @StateObject var gameBoard = GameBoard()
    
    public init() { }

    public var body: some View {
        VStack {

            if let winner = gameBoard.winner {
                Text("\(winner == .red ? "Red" : "Yellow") Wins!")
                    .font(.title)
                    .foregroundColor(winner == .red ? .red : .yellow)
            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(.blue)  // Задний фон доски
                    .frame(width: 350, height: 300)
                    .cornerRadius(10)
                
                VStack(spacing: 5) {
                    ForEach(0..<6, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<7, id: \.self) { column in
                                Circle()
                                    .foregroundColor(self.gameBoard.board[row][column].tile.tileColor())
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        self.gameBoard.dropPiece(in: column)
                                    }
                            }
                        }
                    }
                }
            }
            .padding()
            
            Button {
                // Generate random coin side number
                gameBoard.resetBoard()
            } label: {
                Text("New Game")
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

struct ConnectFourContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectFourContentView()
    }
}

