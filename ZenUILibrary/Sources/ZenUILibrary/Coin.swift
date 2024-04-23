//
//  CoinToss.swift
//  ZenUI
//
//  Created by David on 01.04.2024.
//

import Foundation
import SwiftUI

public struct CoinTossContentView: View {
    public init() { }
    // dice number
    @State private var coinSideNumber = 1
    
    public var body: some View {
        VStack {
            Image("Coin\(coinSideNumber)")
                .resizable()
                .frame(width: 300, height: 300)
                .padding()
            
            Text(coinSideNumber == 1 ? "Heads!" : "Tails!")
                .frame(width: 100, height: 100)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button {
                // Generate random coin side number
                coinSideNumber = Int.random(in: 1...2)
            } label: {
                Text("Toss")
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
