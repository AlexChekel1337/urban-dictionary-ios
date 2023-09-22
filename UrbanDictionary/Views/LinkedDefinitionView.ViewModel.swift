//
//  LinkedDefinitionView.ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

extension LinkedDefinitionView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var words: [Word] = []
        @Published private(set) var canLoad: Bool = true
        @Published private(set) var hasError: Bool = false

        private let service = UrbanDictionaryService()

        func loadDefinition(withId id: String) async {
            hasError = false

            do {
                let result = try await service.definition(id: id)
                words = [result]

                canLoad = false
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
