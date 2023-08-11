//
//  WordOfTheDay.swift
//  WordOfTheDay
//
//  Created by Alexander Chekel on 11.08.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WordOfTheDayEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Fr")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .redacted(reason: .placeholder)
            Spacer()
            Text("An even shorter form of 'for real'. The seemingly new way that under 30's tend to reply to social media posts in agreement to it.")
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
                .redacted(reason: .placeholder)
        }
        .padding()
    }
}

struct WordOfTheDay: Widget {
    let kind: String = "WordOfTheDay"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WordOfTheDayEntryView(entry: entry)
        }
        .configurationDisplayName("Word of the day")
        .description("Displays word of the day on Urban Dictionary")
    }
}

struct WordOfTheDay_Previews: PreviewProvider {
    static var previews: some View {
        WordOfTheDayEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
