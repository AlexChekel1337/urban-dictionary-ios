//
//  LinkedDefinitionView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct LinkedDefinitionView: View {
    @StateObject private var viewModel = ViewModel()

    var termIdentifier: TermIdentifier

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
                            await viewModel.loadDefinition(withId: termIdentifier.id)
                        }
                }
            }
            .padding()
        }
        .background(Color.systemGrouppedBackground)
        .navigationTitle("definition_title")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let identifier = TermIdentifier(id: "34325")
    return LinkedDefinitionView(termIdentifier: identifier)
}
