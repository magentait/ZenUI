//
//  Dice.swift
//  ZenUI
//
//  Created by David on 03.04.2024.
//

import Foundation
import SwiftUI

public struct DiceContentView: View {
    public init() { }
    // dice number
    @State private var diceNumber = 1
    
    func rollDice() {
        diceNumber = Int.random(in: 1...6)
    }
    
    public var body: some View {
        VStack {
            Image("Dice\(diceNumber)")
                .frame(width: 400, height: 400)
                .padding()
            
            BottomButton(text: "Roll", action: rollDice)
                .padding()
        }
    }
}
