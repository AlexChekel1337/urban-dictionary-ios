//
//  SearchSuggestionListView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 30.08.2023.
//

import Combine
import SwiftUI

struct SearchSuggestionListView: View {
    @StateObject var viewModel: ViewModel
    var suggestionSelectionHandler: (String) -> Void

    var body: some View {
        switch viewModel.state {
            case .noQuery:
                EmptyView()
            case .loading:
                ActivityIndicatorView(isAnimating: .constant(true))
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            case .suggestions(let suggestions) where suggestions.isEmpty:
                MessageView(kind: .notFound, title: "error_not_found_title", text: "error_not_found_text")
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            case .suggestions(let suggestions):
                ForEach(suggestions, id: \.self) { suggestion in
                    Button {
                        suggestionSelectionHandler(suggestion)
                    } label: {
                        HStack {
                            Text(suggestion)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            case .error:
                MessageView(
                    kind: .error,
                    title: "error_loading_title",
                    text: "error_loading_text",
                    actionButtonTitle: "error_loading_action"
                ) {
                    viewModel.retry()
                }
                .listRowSeparator(.hidden)
        }
    }
}

struct SearchSuggestionListView_Previews: PreviewProvider {
    static var previews: some View {
        let publisher = PassthroughSubject<String, Never>()
        SearchSuggestionListView(viewModel: .init(searchTermPublisher: publisher.eraseToAnyPublisher())) { _ in }
    }
}
