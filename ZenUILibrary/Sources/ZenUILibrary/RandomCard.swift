//
//  RandomCard.swift
//  ZenUI
//
//  Created by David on 01.04.2024.
//

import Foundation
import SwiftUI

public struct RandomCardContentView: View {
    public init() { }
    
    @State private var cardNumber = 1  // Track the card number
    
    func pullCard() {
        cardNumber = Int.random(in: 1...52)
    }
    
    public var body: some View {
        VStack {
            Image("Card\(cardNumber)")
                .resizable()
                .scaledToFit()
                .frame(width: 222, height: 323)  // Explicitly setting the frame size
                .clipShape(RoundedRectangle(cornerRadius: 10))  // Applying rounded corners
                .overlay(
                    RoundedRectangle(cornerRadius: 10)  // Adding a border with the same rounded corner shape
                        .stroke(Color.gray, lineWidth: 2)
                )
                .padding()  // Adding space around the image
            
            
            BottomButton(text: "Pull", action: pullCard)
                .padding()
        }
    }
}
