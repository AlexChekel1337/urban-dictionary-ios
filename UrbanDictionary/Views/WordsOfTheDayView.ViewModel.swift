//
//  WordsOfTheDayView.ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 21.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

extension WordsOfTheDayView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var words: [Word] = []
        @Published private(set) var canLoad: Bool = true
        @Published private(set) var hasError: Bool = false

        private let service = UrbanDictionaryService()
        private var page: Int = 1
        private var lastLoadDate = Date()

        func load() async {
            hasError = false
            lastLoadDate = Date()

            do {
                let result = try await service.wordsOfTheDay(page: page)
                words.append(contentsOf: result)

                page += 1
                canLoad = result.count == service.pageSize
            } catch {
                hasError = true
                canLoad = false
            }
        }

        func retry() {
            hasError = false
            canLoad = true
        }

        func reloadIfNeeded() {
            // Minimum threshold of refreshing the content is 30 minutes
            let minimumRequiredInterval: TimeInterval = 1800

            guard Date().timeIntervalSince(lastLoadDate) >= minimumRequiredInterval else {
                return
            }

            page = 1
            words = []
            hasError = false
            canLoad = true
        }
    }
}
