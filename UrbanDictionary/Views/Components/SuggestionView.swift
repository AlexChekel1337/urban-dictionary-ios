//
//  SuggestionView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct SuggestionView: View {
    let text: String
    let handler: () -> Void

    var body: some View {
        Button {
            handler()
        } label: {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    SuggestionView(text: "Hello world") {}
}
