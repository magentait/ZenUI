//
//  PushButton.swift
//  ZenUI
//
//  Created by David on 03.04.2024.
//

import SwiftUI


public struct PushButtonContentView: View {
    public init() { }
    
    let soundPlayer = SoundPlayer()
    
    public var body: some View {
        VStack {
            Button(action: {
                soundPlayer.playSound(sound: "push-button", type: "mp3")
            }, label: {
                Image("push-button")
                    .resizable()
                    .frame(width: 250, height: 250)
            }).buttonStyle(.plain)
                .padding(.bottom, 200)
        }
    }
}
