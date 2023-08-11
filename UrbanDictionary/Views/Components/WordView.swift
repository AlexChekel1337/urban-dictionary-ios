//
//  WordView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

struct WordView: View {
    @Environment(\.viewFactory) private var viewFactory

    @State private var isShareSheetPresented: Bool = false
    @State private var isDefinitionViewPresented: Bool = false
    @State private var selectedDefinitionUrl: URL = .nonExistentUrl

    let word: Word

    init(_ word: Word) {
        self.word = word
    }

    var body: some View {
        ZStack {
            NavigationLink(isActive: $isDefinitionViewPresented) {
                viewFactory.makeViewForUrl(selectedDefinitionUrl)
            } label: {
                EmptyView()
            }

            Rectangle()
                .foregroundColor(.systemBackground)
                .cornerRadius(16)

            VStack(spacing: 16) {
                Text(word.word)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack {
                    Text("Definition")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(.init(word.definition))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                VStack {
                    Text("Example usage")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(.init(word.example))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                HStack(spacing: 16) {
                    Text("\(Image(systemName: "hand.thumbsup")) \(word.thumbsUp)")
                    Text("\(Image(systemName: "hand.thumbsdown")) \(word.thumbsDown)")
                    Text("\(Image(systemName: "person")) \(word.author)")
                    Spacer()
                    Button {
                        isShareSheetPresented.toggle()
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.accentColor)
                    }
                    .shareSheet(sharing: word.permalink, isPresented: $isShareSheetPresented)
                }
                .lineLimit(1)
                .font(.footnote)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .environment(\.openURL, OpenURLAction(handler: { url in
                selectedDefinitionUrl = url
                isDefinitionViewPresented = true
                return .handled
            }))
        }
    }
}

struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        let word = Word(
            id: 0,
            word: "Lorem Ipsum",
            definition: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            example: "Lorem ipsum",
            author: "A very long author field that will probably be clipped",
            thumbsUp: 10456,
            thumbsDown: 1876,
            permalink: .init(staticString: "https://google.com")
        )
        WordView(word)
    }
}
