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
    
    func tossCoin() {
        coinSideNumber = Int.random(in: 1...2)
    }
    
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
            
            BottomButton(text: "Toss", action: tossCoin)
                .padding()
        }
    }
}
