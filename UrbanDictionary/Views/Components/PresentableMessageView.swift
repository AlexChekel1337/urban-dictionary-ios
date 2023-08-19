//
//  PresentableMessageView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 11.08.2023.
//

import SwiftUI

struct PresentableMessageView: View {
    let emoji: LocalizedStringKey
    let text: LocalizedStringKey

    var body: some View {
        VStack {
            Text(emoji)
                .font(.largeTitle)
            Text(text)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct PresentableMessageView_Previews: PreviewProvider {
    static var previews: some View {
        PresentableMessageView(emoji: "🔍", text: "Enter a query")
    }
}
