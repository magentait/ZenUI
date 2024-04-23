//
//  RubberDuck.swift
//  ZenUI
//
//  Created by David on 05.04.2024.
//

import SwiftUI


public struct RubberDuckContentView: View {
    public init() { }
    
    let soundPlayer = SoundPlayer()
    
    public var body: some View {
        VStack {
            Button(action: {
                soundPlayer.playSound(sound: "Squeak-Sound-Effect-New", type: "mp3")
            }, label: {
                Image("rubberduck")
                    .resizable()
                    .frame(width: 250, height: 250)
            }).buttonStyle(.plain)
                .padding(.bottom, 200)
        }
    }
}

struct RubberDuckContentView_Previews: PreviewProvider {
    static var previews: some View {
        RubberDuckContentView()
    }
}
