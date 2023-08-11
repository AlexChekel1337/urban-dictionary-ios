//
//  SearchView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        List {
            switch viewModel.state {
                case .noQuery:
                    PresentableMessageView(emoji: "🔍", text: "Enter search request")
                        .listSectionSeparator(.hidden)
                case .loading:
                    ActivityIndicatorView(isAnimating: .constant(true))
                        .frame(maxWidth: .infinity)
                        .listSectionSeparator(.hidden)
                case .suggestions(let suggestions) where suggestions.isEmpty:
                    PresentableMessageView(emoji: "😔", text: "Nothing found")
                        .listSectionSeparator(.hidden)
                case .suggestions(let suggestions):
                    ForEach(suggestions, id: \.self) { suggestion in
                        SuggestionView(suggestion)
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $viewModel.searchTerm,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search definitions"
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView(viewModel: .init())
        }
    }
}
