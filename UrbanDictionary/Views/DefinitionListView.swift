//
//  DefinitionListView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 29.08.2023.
//

import SwiftUI

struct DefinitionListView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.systemGrouppedBackground
                .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: [.init(.flexible())], spacing: 16) {
                    ForEach(viewModel.words) { word in
                        WordView(word)
                    }

                    if viewModel.hasError {
                        MessageView(
                            kind: .error,
                            title: "error_loading_title",
                            text: "error_loading_text",
                            actionButtonTitle: "error_loading_action"
                        ) {
                            viewModel.loadNextPage()
                        }
                    } else if viewModel.isMoreDataAvailable {
                        ActivityIndicatorView(isAnimating: .constant(true))
                            .frame(maxWidth: .infinity)
                            .onAppear {
                                viewModel.loadNextPage()
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(viewModel.shouldUseCompactNavigation ? .inline : .automatic)
    }
}

struct DefinitionListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                DefinitionListView(viewModel: .init(content: .wordsOfTheDay))
                    .previewDisplayName("Words of the day")
            }

            NavigationView {
                DefinitionListView(viewModel: .init(content: .definitions(term: "fr")))
                    .previewDisplayName("Definitions of term")
            }

            NavigationView {
                DefinitionListView(viewModel: .init(content: .definition(id: "1")))
                    .previewDisplayName("Definition by ID")
            }
        }
    }
}
