//
//  FidgetSpinner.swift
//  ZenUI
//
//  Created by David on 03.04.2024.
//

import SwiftUI

public struct FidgetSpinnerContentView: View {
    public init() { }
    
    @State private var angle: Angle = .zero
    @State private var isSpinning = false
    @State private var spinVelocity: Double = 0.0
    @State private var timer: Timer?

    public var body: some View {
        GeometryReader { geometry in
            Image("spinner")  // Ensure you have an image named "fidgetSpinner" in your assets
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 350)
                // Center the spinner
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .rotationEffect(angle)
                .onTapGesture {
                    self.stopSpinning()
                }
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let rotation = Angle(degrees: Double(gesture.translation.width + gesture.translation.height))
                            self.angle += rotation
                            self.spinVelocity = rotation.degrees / 3  // Adjusted for a moderate initial spin speed
                            self.isSpinning = true
                            self.spin()
                        }
                )
            
            /*
            if isSpinning {
                Text("Spinning...")
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
             */
        }
        .onAppear {
            setupDeceleration()
        }
    }
    
    private func spin() {
        timer?.invalidate()  // Invalidate the previous timer if it exists
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.angle += .degrees(spinVelocity)
            self.decelerate()
        }
    }
    
    private func decelerate() {
        if abs(spinVelocity) > 0.1 {
            spinVelocity *= 0.99  // Decelerate by reducing velocity by 1% per tick
        } else {
            stopSpinning()
        }
    }
    
    private func stopSpinning() {
        timer?.invalidate()
        timer = nil
        isSpinning = false
        spinVelocity = 0
    }
    
    private func setupDeceleration() {
        // Setup any initial configuration if needed
    }
}

struct FidgetSpinnerContentView_Previews: PreviewProvider {
    static var previews: some View {
        FidgetSpinnerContentView()
    }
}
