//
//  DefinitionsView-ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import SwiftUI

extension DefinitionsView {
    @MainActor class ViewModel: ObservableObject {
        enum Contents {
            case wordsOfTheDay
            case definitions(term: String)
        }

        let contents: Contents
        @Published private(set) var words: [Word] = []
        @Published private(set) var isMoreDataAvailable: Bool = true

        var navigationTitle: String {
            switch contents {
                case .wordsOfTheDay:
                    return "Words of the day"
                case .definitions:
                    return "Definitions"
            }
        }

        var shouldShowSearch: Bool {
            switch contents {
                case .wordsOfTheDay:
                    return true
                case .definitions:
                    return false
            }
        }

        private let service = UrbanDictionaryService()
        private var currentTask: Task<Void, Never>?
        private var page: Int = 1

        init(contents: Contents) {
            self.contents = contents
        }

        func loadNextPage() {
            currentTask?.cancel()
            currentTask = Task {
                do {
                    let words: [Word]
                    switch contents {
                        case .wordsOfTheDay:
                            words = try await service.wordsOfTheDay(page: page)
                        case .definitions(let term):
                            words = try await service.define(term, page: page)
                    }

                    guard !Task.isCancelled else { return }

                    self.words.append(contentsOf: words)
                    isMoreDataAvailable = !words.isEmpty
                    page += 1
                } catch {
                    isMoreDataAvailable = false
                    print(error)
                }
            }
        }
    }
}
