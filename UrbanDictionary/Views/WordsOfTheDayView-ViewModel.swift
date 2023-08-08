//
//  WordsOfTheDayView-ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

extension WordsOfTheDayView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var words: [Word] = []
        @Published private(set) var isMoreDataAvailable: Bool = true

        private let service = UrbanDictionaryService()
        private var currentTask: Task<Void, Never>?
        private var page: Int = 1

        func loadNextPage() {
            guard isMoreDataAvailable else { return }

            currentTask = Task {
                do {
                    let result = try await service.wordsOfTheDay(page: page)

                    guard !Task.isCancelled else { return }

                    words.append(contentsOf: result)
                    isMoreDataAvailable = !result.isEmpty
                    page += 1
                } catch {
                    isMoreDataAvailable = false
                    print(error)
                }
            }
        }
    }
}
