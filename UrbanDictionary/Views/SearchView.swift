//
//  SearchView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.viewFactory) private var viewFactory

    @StateObject var viewModel: ViewModel

    var body: some View {
        List {
            switch viewModel.state {
                case .noQuery:
                    PresentableMessageView(emoji: "🔍", text: "search_message_enter_query")
                        .listSectionSeparator(.hidden)
                case .loading:
                    ActivityIndicatorView(isAnimating: .constant(true))
                        .frame(maxWidth: .infinity)
                        .listSectionSeparator(.hidden)
                case .error:
                    PresentableMessageView(emoji: "🚧", text: "search_message_error")
                        .listSectionSeparator(.hidden)
                case .suggestions(let suggestions) where suggestions.isEmpty:
                    PresentableMessageView(emoji: "😔", text: "search_message_no_results")
                        .listSectionSeparator(.hidden)
                case .suggestions(let suggestions):
                    ForEach(suggestions, id: \.self) { suggestion in
                        NavigationLink {
                            viewFactory.makeDefinitionsView(defining: suggestion.term)
                        } label: {
                            SuggestionView(suggestion)
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("search_title")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $viewModel.searchTerm,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "search_text_field_prompt"
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
