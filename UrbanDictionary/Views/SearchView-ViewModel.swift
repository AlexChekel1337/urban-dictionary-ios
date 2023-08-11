//
//  SearchView-ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import Combine
import SwiftUI

extension SearchView {
    @MainActor class ViewModel: ObservableObject {
        enum State {
            case noQuery
            case loading
            case suggestions([Suggestion])
            case error
        }

        @Published private(set) var state: State = .suggestions([])
        @Published var searchTerm: String = ""

        private let service = UrbanDictionaryService()
        private var searchTermObservationCancellable: AnyCancellable?
        private var currentTask: Task<Void, Never>?

        init() {
            searchTermObservationCancellable =  $searchTerm
                .sink { [weak self] term in
                    self?.performSearch(for: term)
                }
        }

        private func performSearch(for term: String) {
            guard !term.isEmpty else {
                return state = .noQuery
            }

            state = .loading

            currentTask?.cancel()
            currentTask = Task {
                do {
                    try await Task.sleep(nanoseconds: 1_000_000_000 * 1)
                    let results = try await service.autocomplete(query: term)

                    guard !Task.isCancelled else { return }

                    state = .suggestions(results)
                } catch {
                    if error is CancellationError {
                        // Do nothing
                    } else {
                        print(error)
                        state = .error
                    }
                }
            }
        }
    }
}
