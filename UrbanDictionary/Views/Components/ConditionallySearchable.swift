//
//  ConditionallySearchable.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 30.08.2023.
//

import SwiftUI

extension View {
    @ViewBuilder func searchable(
        if condition: Bool,
        text: Binding<String>,
        placement: SearchFieldPlacement = .automatic,
        prompt: LocalizedStringKey,
        @ViewBuilder suggestions: () -> some View
    ) -> some View {
        if condition {
            self.searchable(text: text, placement: placement, prompt: prompt, suggestions: suggestions)
        } else {
            self
        }
    }
}
