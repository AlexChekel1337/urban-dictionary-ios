//
//  WordView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct WordView: View {
    let word: Word

    init(_ word: Word) {
        self.word = word
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.secondarySystemGrouppedBackground)
                .cornerRadius(16)

            VStack(spacing: 16) {
                Text(word.word)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack {
                    Text("word_definition")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(.init(word.definition))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                VStack {
                    Text("word_example_usage")
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

                    ShareLink(item: word.permalink) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.accentColor)
                    }
                }
                .lineLimit(1)
                .font(.footnote)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding()
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
            permalink: .init(staticString: "https://google.com"),
            writtenOn: Date()
        )
        WordView(word)
    }
}
