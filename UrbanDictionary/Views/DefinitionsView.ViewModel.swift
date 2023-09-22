//
//  DefinitionsView.ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

extension DefinitionsView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var words: [Word] = []
        @Published private(set) var canLoad: Bool = true
        @Published private(set) var hasError: Bool = false

        private let service = UrbanDictionaryService()
        private var page: Int = 1

        func loadDefinitions(for term: String) async {
            hasError = false

            do {
                let result = try await service.define(term, page: page)
                words.append(contentsOf: result)

                page += 1
                canLoad = !result.isEmpty
            } catch {
                hasError = true
                canLoad = false
            }
        }

        func retry() {
            hasError = false
            canLoad = true
        }
    }
}
