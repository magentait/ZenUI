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
    
    func generateNumber() {
        randomNumber = Int.random(in: 1..<1000)
    }
    
    public var body: some View {
        VStack {
            Text("\(randomNumber)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: 400, height: 400)
                .padding()
            
            
            BottomButton(
                text: "Generate",
                action: generateNumber,
                bodyColor: Color("brandSecondary")
            )
            .padding()
        }
    }
}
