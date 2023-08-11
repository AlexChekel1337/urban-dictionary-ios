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
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(suggestion.preview)
                .font(.footnote)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        let suggestion1 = Suggestion(term: "Burger", preview: "Burger means dummy")
        let suggestion2 = Suggestion(term: "Lorem Ipsum", preview: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper sagittis posuere. Pellentesque sagittis venenatis est, quis aliquam velit pretium a. Morbi velit velit, bibendum eu blandit sed, fringilla ac augue.")

        List {
            SuggestionView(suggestion1)
            SuggestionView(suggestion2)
        }
        .listStyle(.plain)
    }
}
