//
//  CookieClicker.swift
//  ZenUI
//
//  Created by David on 01.04.2024.
//

import SwiftUI


public struct CookieClickerContentView: View {
    public init() { }
    
    @State var cookies: Int = 0
    
    func resetCookies() {
        cookies = 0
    }
    
    public var body: some View {
        VStack {
            
            
            Text("\(cookies)")
                .font(.title)
                .fontWeight(.bold)
            
            .padding()
            
            Button(action: {
                cookies = cookies + 1
            }, label: {
                Image("Cookie")
                    .resizable()
                    .frame(width: 250, height: 250)
            }).buttonStyle(.plain)
                .padding(.bottom, 100)
            
            BottomButton(
                text: "Reset Cookies",
                action: resetCookies
            )
            .padding()
        }
    }
}
