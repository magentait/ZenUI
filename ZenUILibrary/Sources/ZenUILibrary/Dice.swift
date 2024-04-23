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
    
    public var body: some View {
        VStack {
            Image("Dice\(diceNumber)")
                .frame(width: 400, height: 400)
                .padding()
            
            Button {
                // Generate random dice number
                diceNumber = Int.random(in: 1...6)
            } label: {
                Text("Roll")
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
