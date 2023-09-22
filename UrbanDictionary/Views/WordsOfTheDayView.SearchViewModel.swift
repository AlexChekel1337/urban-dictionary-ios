//
//  WordsOfTheDayView.SearchViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

extension WordsOfTheDayView {
    @MainActor class SearchViewModel: ObservableObject {
        @Published private(set) var suggestions: [String] = []

        private let service = UrbanDictionaryService()
        private var task: Task<Void, Never>?

        func search(for term: String) {
            task?.cancel()
            suggestions = []

            let trimmedTerm = term.trimmingCharacters(in: .whitespacesAndNewlines)

            guard !trimmedTerm.isEmpty else { return }

            task = Task {
                do {
                    // Delaying the request in case more characters are typed in
                    try await Task.sleep(for: .seconds(1))

                    let result = try await service.autocomplete(query: trimmedTerm)
                    suggestions = result
                } catch {
                    // Thrown errors won't affect UI
                }
            }
        }
    }
}
