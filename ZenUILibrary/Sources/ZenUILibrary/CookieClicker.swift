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
            
            
            Button(action: {
                cookies = 0
            }, label: {
                Text("Reset Cookies")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(width: 280, height: 50)  // Button size
                    .foregroundColor(.white)
                    .background(Color("brandPrimary"))  // Using a custom color
                    .cornerRadius(10)
            }).buttonStyle(.plain)
        }
    }
}
