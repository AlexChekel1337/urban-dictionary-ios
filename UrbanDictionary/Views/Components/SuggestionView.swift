//
//  SuggestionView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import SwiftUI

struct SuggestionView: View {
    let suggestion: Suggestion

    init(_ suggestion: Suggestion) {
        self.suggestion = suggestion
    }

    var body: some View {
        VStack {
            Text(suggestion.term)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(suggestion.preview)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        let suggestion = Suggestion(term: "Burger", preview: "Burger means dummy")
        SuggestionView(suggestion)
    }
}
