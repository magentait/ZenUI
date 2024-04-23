//
//  Slider.swift
//  ZenUI
//
//  Created by David on 05.04.2024.
//

import SwiftUI
import Foundation

struct CustomSwitch: View {
    @Binding var isOn: Bool
    var soundPlayer: SoundPlayer

    var body: some View {
        HStack {
            if isOn {
                Text("ON")
                    .font(.title)
                    .foregroundColor(.white)
                    .animation(.none, value: isOn)
            }

            // Слайдер
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(isOn ? Color.green : Color.gray)
                    .frame(width: 75, height: 45)
                    .shadow(color: .gray, radius: 4.5, x: 0, y: 3)
                
                // Круглый ползунок слайдера
                Circle()
                    .frame(width: 42, height: 42)
                    .foregroundColor(.white)
                    .shadow(radius: 4.5)
                    .offset(x: isOn ? 15 : -15, y: 0)
                    .animation(.spring(response: 0.2, dampingFraction: 0.5), value: isOn)
            }
            .onTapGesture {
                withAnimation {
                    isOn.toggle()
                }
                soundPlayer.playSound(sound: isOn ? "slider-on" : "slider-off", type: "mp3")
            }

            if !isOn {
                Text("OFF")
                    .font(.title)
                    .foregroundColor(.white)
                    .animation(.none, value: isOn)
            }
        }
        .padding(.horizontal)
    }
}

public struct SliderContentView: View {
    public init() { }
    
    let soundPlayer = SoundPlayer()
    @State private var switchIsOn = false

    public var body: some View {
        VStack {
            Spacer()
            CustomSwitch(isOn: $switchIsOn, soundPlayer: soundPlayer)
                .padding()
                .background(switchIsOn ? Color.blue : Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .animation(.easeInOut, value: switchIsOn)
            
            Spacer()
        }
        .padding()
        
    }
}

struct SliderContentView_Previews: PreviewProvider {
    static var previews: some View {
        SliderContentView()
    }
}
