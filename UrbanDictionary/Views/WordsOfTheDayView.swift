//
//  WordsOfTheDayView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 21.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct WordsOfTheDayView: View {
    @Environment(\.coordinatorObject) private var coordinator
    @Environment(\.scenePhase) private var scenePhase

    @StateObject private var viewModel = ViewModel()
    @StateObject private var searchViewModel = SearchViewModel()
    @State private var searchTerm: String = ""

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
                            await viewModel.load()
                        }
                }
            }
            .padding()
        }
        .background(Color.systemGrouppedBackground)
        .navigationTitle("words_of_the_day_title")
        .searchable(text: $searchTerm)
        .searchSuggestions {
            ForEach(searchViewModel.suggestions, id: \.self) { suggestion in
                SuggestionView(text: suggestion) {
                    coordinator.showDefinitions(of: suggestion)
                }
            }
        }
        .onChange(of: searchTerm) { value in
            searchViewModel.search(for: value)
        }
        .onChange(of: scenePhase) { value in
            guard value == .active else { return }

            viewModel.reloadIfNeeded()
        }
    }
}

#Preview {
    NavigationView {
        WordsOfTheDayView()
    }
}
