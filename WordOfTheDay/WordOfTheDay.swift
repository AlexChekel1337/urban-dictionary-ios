//
//  WordOfTheDay.swift
//  WordOfTheDay
//
//  Created by Alexander Chekel on 11.08.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import WidgetKit
import SwiftUI

struct WordEntry: TimelineEntry {
    var date: Date
    var word: String
    var definition: String
    var id: Int
    var isPlaceholder: Bool
}

extension WordEntry {
    static let placeholder = WordEntry(
        date: Date(),
        word: "iPhone",
        definition: "A device that gets bigger every year",
        id: 0,
        isPlaceholder: true
    )
}

struct Provider: TimelineProvider {
    private let service = UrbanDictionaryService()

    func placeholder(in context: Context) -> WordEntry {
        WordEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (WordEntry) -> ()) {
        Task {
            do {
                let results = try await service.wordsOfTheDay()
                let wordOfTheDay = results[0]

                let entry = WordEntry(
                    date: Date(),
                    word: wordOfTheDay.word,
                    definition: wordOfTheDay.definition,
                    id: wordOfTheDay.id,
                    isPlaceholder: false
                )
                completion(entry)
            } catch {
                print(error)
                completion(WordEntry.placeholder)
            }
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries = [WordEntry]()

            do {
                let results = try await service.wordsOfTheDay()
                let wordOfTheDay = results[0]

                let entry = WordEntry(
                    date: Date(),
                    word: wordOfTheDay.word,
                    definition: wordOfTheDay.definition,
                    id: wordOfTheDay.id,
                    isPlaceholder: false
                )
                entries.append(entry)
            } catch {
                print(error)
                entries.append(WordEntry.placeholder)
            }

            let updateInterval = Date().addingTimeInterval(60 * 60)
            let timeline = Timeline(entries: entries, policy: .after(updateInterval))
            completion(timeline)
        }
    }
}

struct WordOfTheDayEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("widget_word_of_the_day_title")
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
        .padding()
        .widgetURL(URL(string: "urbandictionary:///definition?id=\(entry.id)"))
    }
}

struct WordOfTheDay: Widget {
    let kind: String = "WordOfTheDay"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WordOfTheDayEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("widget_word_of_the_day_title")
        .description("widget_word_of_the_date_description")
    }
}

struct WordOfTheDay_Previews: PreviewProvider {
    static var previews: some View {
        var entry = WordEntry.placeholder
        entry.isPlaceholder = false

        return Group {
            WordOfTheDayEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .previewDisplayName(".systemSmall")
            WordOfTheDayEntryView(entry: entry)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDisplayName(".systemMedium")
        }
    }
}
