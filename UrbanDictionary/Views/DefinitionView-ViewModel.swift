//
//  DefinitionView-ViewModel.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 13.08.2023.
//

import SwiftUI

extension DefinitionView {
    @MainActor class ViewModel: ObservableObject {
        let word: Word

        init(word: Word) {
            self.word = word
        }
    }
}
