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
        }

        @Published private(set) var state: State = .suggestions([])

        @Published var searchTerm: String = ""
        @Published private(set) var suggestions: [Suggestion] = []

        private let service = UrbanDictionaryService()
        private var searchTermObservationCancellable: AnyCancellable?
        private var currentTask: Task<Void, Never>?

        init() {
            searchTermObservationCancellable =  $searchTerm
                .debounce(for: 1, scheduler: DispatchQueue.main)
                .sink { [weak self] term in
                    self?.performSearch(for: term)
                }
        }

        private func performSearch(for term: String) {
            guard !term.isEmpty else {
                suggestions = [.init(term: "Enter search term", preview: "Bottom text")]
                return
            }

            print("Will search for '\(term)'")

            currentTask = Task {
                do {
                    let results = try await service.autocomplete(query: term)

                    guard !Task.isCancelled else { return }

                    suggestions = results
                } catch {
                    print(error)
                }
            }
        }
    }
}
