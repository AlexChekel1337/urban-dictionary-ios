//
//  DefinitionsView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct DefinitionsView: View {
    @StateObject private var viewModel = ViewModel()

    var definableTerm: DefinableTerm

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.flexible())], spacing: 16) {
                ForEach(viewModel.words) { word in
                    WordView(word)
                }

                if viewModel.hasError {
                    ErrorMessageView {
                        viewModel.retry()
                    }
                } else if viewModel.canLoad {
                    ActivityIndicatorView(isAnimating: .constant(true))
                        .task {
                            await viewModel.loadDefinitions(for: definableTerm.term)
                        }
                }
            }
            .padding()
        }
        .background(Color.systemGrouppedBackground)
        .navigationTitle(LocalizedString("definitions_of_title", arguments: definableTerm.term))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview("DefinitionsView") {
    NavigationView {
        DefinitionsView(definableTerm: .init(term: "iPhone"))
    }
}
