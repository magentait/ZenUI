//
//  FidgetToyGridView.swift
//  ZenUI
//
//  Created by David on 22.03.2024.
//

import SwiftUI
import ZenUILibrary

struct FidgetToyGridView: View {
    
    @StateObject var viewModel = FidgetToyGridViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(FidgetToysData.fidgetToys) { fidgetToy in
                        NavigationLink(value: fidgetToy) {
                            FidgetToyTitleView(fidgetToy: fidgetToy)
                        }
                    }
                }
            }
            .navigationTitle("🪀 Fidget Toys")
            .navigationDestination(for: FidgetToy.self) { fidgetToy in
                FidgetToyDetailView(fidgetToy: fidgetToy)
            }
        }
    }
}

struct FidgetToyGridView_Previews: PreviewProvider {
    static var previews: some View {
        FidgetToyGridView()
            .preferredColorScheme(.light)
    }
}
