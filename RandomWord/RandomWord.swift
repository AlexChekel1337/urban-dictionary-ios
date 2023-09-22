//
//  RandomWord.swift
//  RandomWord
//
//  Created by Alexander Chekel on 13.08.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import WidgetKit
import SwiftUI

struct RandomWordEntry: TimelineEntry {
    var date: Date
    var word: String
    var definition: String
    var id: Int
    var isPlaceholder: Bool
}

extension RandomWordEntry {
    static let placeholder = RandomWordEntry(
        date: Date(),
        word: "iPhone",
        definition: "A device that gets bigger every year",
        id: 0,
        isPlaceholder: true
    )
}

struct Provider: TimelineProvider {
    private let service = UrbanDictionaryService()

    func placeholder(in context: Context) -> RandomWordEntry {
        RandomWordEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (RandomWordEntry) -> ()) {
        Task {
            do {
                let results = try await service.randomWords()
                let randomWord = results[0]

                let entry = RandomWordEntry(
                    date: Date(),
                    word: randomWord.word,
                    definition: randomWord.definition,
                    id: randomWord.id,
                    isPlaceholder: false
                )
                completion(entry)
            } catch {
                print(error)
                completion(RandomWordEntry.placeholder)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries = [RandomWordEntry]()

            do {
                let results = try await service.randomWords()
                let randomWord = results[0]

                let entry = RandomWordEntry(
                    date: Date(),
                    word: randomWord.word,
                    definition: randomWord.definition,
                    id: randomWord.id,
                    isPlaceholder: false
                )
                entries.append(entry)
            } catch {
                print(error)
                entries.append(RandomWordEntry.placeholder)
            }

            let updateInterval = Date().addingTimeInterval(60 * 60)
            let timeline = Timeline(entries: entries, policy: .after(updateInterval))
            completion(timeline)
        }
    }
}

struct RandomWordEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("widget_random_word_title")
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(.init(entry.word))
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .redacted(reason: entry.isPlaceholder ? .placeholder : [])
                .tint(.primary)
                .layoutPriority(1)
            Spacer()
            Text(.init(entry.definition))
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .redacted(reason: entry.isPlaceholder ? .placeholder : [])
                .tint(.primary)
        }
        .applyingWidgetPadding()
        .applyingDefaultWidgetBackground()
        .widgetURL(URL(string: "urbandictionary:///definition?id=\(entry.id)"))
    }
}

struct RandomWord: Widget {
    let kind: String = "RandomWord"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RandomWordEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("widget_random_word_title")
        .description("widget_random_word_description")
    }
}

struct RandomWord_Previews: PreviewProvider {
    static var previews: some View {
        var entry = RandomWordEntry.placeholder
        entry.isPlaceholder = false

        return Group {
            RandomWordEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName(".systemSmall")
            RandomWordEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDisplayName(".systemMedium")
        }
    }
}
