//
//  DefinitionListView-ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 29.08.2023.
//

import SwiftUI

extension DefinitionListView {
    @MainActor class ViewModel: ObservableObject {
        enum Content {
            case wordsOfTheDay
            case definitions(term: String)
            case definition(id: String)
        }

        @Published private(set) var words: [Word] = []
        @Published private(set) var isLoading: Bool = false
        @Published private(set) var hasError: Bool = false
        @Published var searchTerm: String = ""

        var shouldShowAccessoryViews: Bool {
            switch content {
                case .wordsOfTheDay:
                    return true
                case .definitions, .definition:
                    return false
            }
        }

        var shouldUseCompactNavigation: Bool {
            switch content {
                case .definitions, .definition:
                    return true
                case .wordsOfTheDay:
                    return false
            }
        }

        var navigationTitle: String {
            switch content {
                case .wordsOfTheDay:
                    return LocalizedString("words_of_the_day_title")
                case .definitions(let term):
                    return String(format: LocalizedString("definitions_of_title"), term)
                case .definition:
                    return LocalizedString("definition_title")
            }
        }

        lazy var searchViewModel: SearchSuggestionListView.ViewModel = {
            let viewModel = SearchSuggestionListView.ViewModel(searchTermPublisher: $searchTerm.eraseToAnyPublisher())
            return viewModel
        }()

        private let content: Content
        private let service: UrbanDictionaryService = .init()

        private var pageIndex: Int = 1
        private var contentTask: Task<Void, Never>?
        private var isMoreDataAvailable: Bool = true

        init(content: Content) {
            self.content = content

            load()
        }

        func loadNextPageIfNeeded(after word: Word) {
            if word.id == words.last?.id {
                load()
            }
        }

        func retry() {
            load(isRetrying: true)
        }

        private func load(isRetrying: Bool = false) {
            guard !isLoading && isMoreDataAvailable || isRetrying else { return }

            switch content {
                case .wordsOfTheDay:
                    loadWordsOfTheDay()
                case .definitions(let term):
                    loadDefinitions(term: term)
                case .definition(let id):
                    loadDefinition(id: id)
            }
        }

        private func loadWordsOfTheDay() {
            isLoading = true
            hasError = false

            contentTask?.cancel()
            contentTask = Task {
                do {
                    let result = try await service.wordsOfTheDay(page: pageIndex)

                    guard !Task.isCancelled else { return }

                    words.append(contentsOf: result)
                    hasError = false
                    isMoreDataAvailable = !result.isEmpty
                    pageIndex += 1
                } catch {
                    hasError = true
                    isMoreDataAvailable = false
                }

                isLoading = false
            }
        }

        private func loadDefinitions(term: String) {
            isLoading = true
            hasError = false

            contentTask?.cancel()
            contentTask = Task {
                do {
                    let result = try await service.define(term, page: pageIndex)

                    guard !Task.isCancelled else { return }

                    words.append(contentsOf: result)
                    hasError = false
                    isMoreDataAvailable = !result.isEmpty
                    pageIndex += 1
                } catch {
                    hasError = true
                    isMoreDataAvailable = false
                }

                isLoading = false
            }
        }

        private func loadDefinition(id: String) {
            isLoading = false
            hasError = false

            contentTask?.cancel()
            contentTask = Task {
                do {
                    let result = try await service.definition(id: id)

                    guard !Task.isCancelled else { return }

                    words.append(result)
                    hasError = false
                    isMoreDataAvailable = false
                } catch {
                    hasError = true
                    isMoreDataAvailable = false
                }

                isLoading = false
            }
        }
    }
}
