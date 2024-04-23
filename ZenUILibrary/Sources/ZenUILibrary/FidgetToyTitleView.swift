//
//  FidgetToyTitleView.swift
//  ZenUI
//
//  Created by David on 25.03.2024.
//

import SwiftUI

public struct FidgetToyTitleView: View {
    let fidgetToy: FidgetToy
    
    public init(fidgetToy: FidgetToy) {
        self.fidgetToy = fidgetToy
    }
    
    public var body: some View {
        VStack {
            Image(fidgetToy.imageName)
                .resizable()
                .frame(width: 50, height: 50)
            Text(fidgetToy.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.label))
                .scaledToFit()
                .minimumScaleFactor(0.6)
        }
        .padding()
    }
}

 struct FidgetToyTitleView_Previews: PreviewProvider {
    static var previews: some View {
        FidgetToyTitleView(fidgetToy: FidgetToysData.sampleFidgetToy)
    }
}

