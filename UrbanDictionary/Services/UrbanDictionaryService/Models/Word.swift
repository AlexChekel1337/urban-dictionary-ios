//
//  Word.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import Foundation

struct Word: Codable, Identifiable {
    private static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)
        return formatter
    }()

    // Parsed from `defid` as `id` for the sake of Identifiable conformance
    let id: Int

    let word: String
    let definition: String
    let example: String
    let author: String
    let thumbsUp: Int
    let thumbsDown: Int
    let permalink: URL
    let writtenOn: Date

    private enum CodingKeys: String, CodingKey {
        case id = "defid"

        case word
        case definition
        case example
        case author
        case thumbsUp = "thumbs_up"
        case thumbsDown = "thumbs_down"
        case permalink
        case writtenOn = "written_on"
    }

    init(
        id: Int,
        word: String,
        definition: String,
        example: String,
        author: String,
        thumbsUp: Int,
        thumbsDown: Int,
        permalink: URL,
        writtenOn: Date
    ) {
        self.id = id
        self.word = word
        self.definition = definition
        self.example = example
        self.author = author
        self.thumbsUp = thumbsUp
        self.thumbsDown = thumbsDown
        self.permalink = permalink
        self.writtenOn = writtenOn
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.word = try container.decode(String.self, forKey: .word)

        let rawDefinition = try container.decode(String.self, forKey: .definition)
        self.definition = try UrbanDictionaryLinkTransformer.transform(from: rawDefinition)

        let rawExample = try container.decode(String.self, forKey: .example)
        self.example = try UrbanDictionaryLinkTransformer.transform(from: rawExample)

        self.author = try container.decode(String.self, forKey: .author)
        self.thumbsUp = try container.decode(Int.self, forKey: .thumbsUp)
        self.thumbsDown = try container.decode(Int.self, forKey: .thumbsDown)
        self.permalink = try container.decode(URL.self, forKey: .permalink)

        let writtenOnDateString = try container.decode(String.self, forKey: .writtenOn)
        if let writtenOnDate = Self.dateFormatter.date(from: writtenOnDateString) {
            self.writtenOn = writtenOnDate
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .writtenOn,
                in: container,
                debugDescription: "Expected date string to be in ISO 8601 format"
            )
        }
    }
}
