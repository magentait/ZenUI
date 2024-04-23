//
//  BottomButton.swift
//  ZenUI
//
//  Created by David on 23.04.2024.
//

import Foundation
import SwiftUI

struct BottomButton: View {
    var text: String
    var action: () -> Void
    var bodyColor: Color = Color("brandPrimary")
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title2)
                .fontWeight(.semibold)
                .frame(width: 280, height: 50)
                .foregroundColor(.white)
                .background(bodyColor)
                .cornerRadius(10)
        }
    }
}
