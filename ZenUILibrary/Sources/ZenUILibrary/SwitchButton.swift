//
//  SwitchButton.swift
//  ZenUI
//
//  Created by David on 05.04.2024.
//

import SwiftUI

public struct SwitchButtonContentView: View {
    public init() { }
    
    @State private var isOn = false
    private let soundPlayer = SoundPlayer()

    public var body: some View {
        ZStack {
            Image("switch-off")  // Изображение выключенного переключателя
                .resizable()
                .opacity(isOn ? 0 : 1)
                .animation(.easeInOut(duration: 0.1), value: isOn)

            Image("switch-on")  // Изображение включенного переключателя
                .resizable()
                .opacity(isOn ? 1 : 0)
                .animation(.easeInOut(duration: 0.1), value: isOn)
        }
        .frame(width: 232, height: 303) // Установите соответствующие размеры
        .onTapGesture {
            soundPlayer.playSound(sound: "switchSound", type: "mp3")
            isOn.toggle()
        }
        Spacer()
    }
}


struct SwitchButton_Previews: PreviewProvider {
    static var previews: some View {
        SwitchButtonContentView()
    }
}
