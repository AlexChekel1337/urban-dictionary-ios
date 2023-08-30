//
//  SearchSuggestionListView-ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 30.08.2023.
//

import Combine
import SwiftUI

extension SearchSuggestionListView {
    @MainActor class ViewModel: ObservableObject {
        enum State {
            case noQuery
            case loading
            case suggestions([String])
            case error
        }

        @Published private(set) var state: State = .noQuery

        private let service: UrbanDictionaryService = .init()
        private var searchTermCancellable: AnyCancellable?
        private var currentSearchTask: Task<Void, Never>?

        init(searchTermPublisher: AnyPublisher<String, Never>) {
            searchTermCancellable = searchTermPublisher.sink { [weak self] value in
                self?.performSearch(for: value)
            }
        }

        func retry() { /* retry with last saved term */ }

        private func performSearch(for term: String) {
            let trimmedTerm = term.trimmingCharacters(in: .whitespacesAndNewlines)

            guard !trimmedTerm.isEmpty else {
                currentSearchTask?.cancel()
                state = .noQuery
                return
            }

            state = .loading

            currentSearchTask?.cancel()
            currentSearchTask = Task {
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000 * 1)
                    let results = try await service.autocomplete(query: trimmedTerm)

                    guard !Task.isCancelled else { return }

                    state = .suggestions(results)
                } catch {
                    if error is CancellationError {
                        // Do nothing
                    } else {
                        state = .error
                    }
                }
            }
        }
    }
}
