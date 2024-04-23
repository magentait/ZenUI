//
//  RandomNumberGenerator.swift
//  ZenUI
//
//  Created by David on 01.04.2024.
//

import Foundation
import SwiftUI

public struct RandomNumberGeneratorView: View {
    @State private var randomNumber: Int
    
    public init(randomNumber: Int = 0) {
        self._randomNumber = State(initialValue: randomNumber)
    }
    
    public var body: some View {
        VStack {
            Text("\(randomNumber)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: 400, height: 400)
                .padding()
            
            Button {
                // Generate random number
                randomNumber = Int.random(in: 1..<1000)
            } label: {
                Text("Generate")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 280, height: 50)
                    .background(Color("brandSecondary"))
                    .foregroundColor(.white)
                    .background(Color("brandSecondary"))
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
