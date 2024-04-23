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

            Button(action: {
                cardNumber = Int.random(in: 1...52)  // Randomly update the card number
            }) {
                Text("Pull")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 280, height: 50)  // Button size
                    .foregroundColor(.white)
                    .background(Color("brandPrimary"))  // Using a custom color
                    .cornerRadius(10)
            }
            .padding()  // Padding around the button
        }
    }
}
