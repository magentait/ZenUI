//
//  Xylophone.swift
//  ZenUI
//
//  Created by David on 07.04.2024.
//

import SwiftUI

struct XylophoneBar {
    var note: String
    var color: Color
}

struct XylophoneBarView: View {
    var bar: XylophoneBar
    var soundPlayer: SoundPlayer

    var body: some View {
        Button {
            soundPlayer.playSound(sound: bar.note, type: "wav")
        } label: {
            Text(bar.note)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(bar.color)
                .cornerRadius(15)
        }
    }
}

public struct XylophoneContentView: View {
    public init() { }
    
    let soundPlayer = SoundPlayer()
    
    let bars = [
        XylophoneBar(note: "C", color: Color("KindaPink")),
        XylophoneBar(note: "D", color: Color("KindaCherokee")),
        XylophoneBar(note: "E", color: Color("KindaRose")),
        XylophoneBar(note: "F", color: Color("KindaSandy")),
        XylophoneBar(note: "G", color: Color("KindaTurquoise")),
        XylophoneBar(note: "A", color: Color("KindaMint")),
        XylophoneBar(note: "B", color: Color("KindaTeal"))
    ]
    
    public var body: some View {
        VStack {
            ForEach(bars.indices, id: \.self) { index in
                XylophoneBarView(bar: bars[index], soundPlayer: soundPlayer)
                    .frame(height: 44)
                    .padding(.horizontal, CGFloat(70 + 10 * index))
            }
        }
        Spacer()
    }
}

struct XylophoneContentView_Previews: PreviewProvider {
    static var previews: some View {
        XylophoneContentView()
    }
}
