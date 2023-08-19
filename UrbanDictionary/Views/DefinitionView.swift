//
//  DefinitionView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 13.08.2023.
//

import SwiftUI

struct DefinitionView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.systemGrouppedBackground
                .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: [.init(.flexible())]) {
                    WordView(viewModel.word)
                }
                .padding()
            }
        }
        .navigationTitle("definition_title")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DefinitionView_Previews: PreviewProvider {
    static var previews: some View {
        let word = Word(
            id: 0,
            word: "iPhone",
            definition: "A device that gets bigger every year",
            example: "I just got a new iPhone in August",
            author: "Author",
            thumbsUp: 123,
            thumbsDown: 23,
            permalink: .nonExistentUrl
        )
        NavigationView {
            DefinitionView(viewModel: .init(word: word))
        }
    }
}
