//
//  Magic8Ball.swift
//  ZenUI
//
//  Created by David on 01.04.2024.
//

import SwiftUI
import Foundation


public struct Magic8BallContentView: View {
    
    public init() { }
    
    @State private var text = "Ask"
    
    private let textArray = [
        "It is Certain.",
        "It is decidedly so.",
        "Without a doubt.",
        "Yes definitely.",
        "You may rely on it.",
        "As I see it, yes.",
        "Most likely.",
        "Outlook good.",
        "Yes.",
        "Signs point to yes.",
        "Reply hazy, try again.",
        "Ask again later.",
        "Better not tell you now.",
        "Cannot predict now.",
        "Concentrate and ask again.",
        "Don't count on it.",
        "My reply is no.",
        "My sources say no.",
        "Outlook not so good.",
        "Very doubtful."
    ]
    
    //animation
    @State private var opacity: Double = 1
    
    private func changeText() {
        withAnimation(.easeInOut(duration: 0.3)) {
            opacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                text = textArray.randomElement() ?? "Error"
                opacity = 1
            }
        }
    }
    
    public var body: some View {
        ZStack {
            Image("ball")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.95)
            
            Text(text)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 200, height: 200)
                .multilineTextAlignment(.center)
                .opacity(opacity)
                
                .onTapGesture {
                    changeText()
                }
            
        }
        Spacer()
    }
}
