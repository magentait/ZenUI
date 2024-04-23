//
//  Chamomile.swift
//  ZenUI
//
//  Created by David on 01.04.2024.
//

import SwiftUI

struct ChamomileView: View {
    @State private var petals: [Bool]

    init() {
        _petals = State(initialValue: Array(repeating: true, count: 12))
    }
    
    func resetPetals() {
        withAnimation {
            for i in petals.indices {
                petals[i] = true
            }
        }
    }

    var body: some View {
        VStack {
            ZStack {
                ForEach(petals.indices, id: \.self) { i in
                    if petals[i] {
                        Petal()
                            .foregroundColor(Color("daisyColor"))
                            .rotationEffect(Angle(degrees: Double(i) * 360.0 / Double(petals.count)))
                            .onTapGesture {
                                withAnimation {
                                    petals[i] = false  // Pluck the petal
                                }
                            }
                    }
                }
                Circle()  // Center of the daisy
                    .fill(Color.orange)
                    .frame(width: 40, height: 40)
            }
            .frame(width: 250, height: 350)
            .padding()
            
            BottomButton(
                text: "Reset Petals",
                action: resetPetals,
                bodyColor: Color("brandSecondary")
            )
            .padding()
        }
    }
}

struct Petal: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY - 120),
                          control: CGPoint(x: rect.midX - 60, y: rect.midY - 60))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                          control: CGPoint(x: rect.midX + 60, y: rect.midY - 60))
        return path
    }
}

public struct ChamomileContentView: View {
    public init() { }
    
    public var body: some View {
        ChamomileView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
    }
}

struct ChamomileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChamomileContentView()
    }
}
