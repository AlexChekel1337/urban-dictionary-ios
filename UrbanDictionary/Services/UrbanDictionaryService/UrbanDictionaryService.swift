//
//  UrbanDictionaryService.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import Foundation

private struct ListResponse<T: Codable>: Codable {
    let list: [T]
}

private struct ResultsResponse<T: Codable>: Codable {
    let results: [T]
}

enum UrbanDictionaryServiceError: Error {
    case notFound
}

class UrbanDictionaryService {
    private let client: HTTPClient = .init(baseUrl: "https://api.urbandictionary.com")

    func wordsOfTheDay(page: Int = 1) async throws -> [Word] {
        let parameters = ["page": "\(page)"]
        let response: ListResponse<Word> = try await client.get(path: "/v0/words_of_the_day", parameters: parameters)

        return response.list
    }

    func randomWords(page: Int = 1) async throws -> [Word] {
        let parameters = ["page": "\(page)"]
        let response: ListResponse<Word> = try await client.get(path: "/v0/random", parameters: parameters)

        return response.list
    }

    func define(_ term: String, page: Int = 1) async throws -> [Word] {
        let parameters = [
            "term": term,
            "page": "\(page)"
        ]

        let response: ListResponse<Word> = try await client.get(path: "/v0/define", parameters: parameters)

        return response.list
    }

    func definition(id: String) async throws -> Word {
        let parameters = ["defid": id]
        let response: ListResponse<Word> = try await client.get(path: "/v0/define", parameters: parameters)

        if let word = response.list.first {
            return word
        } else {
            throw UrbanDictionaryServiceError.notFound
        }
    }

    func autocomplete(query: String) async throws -> [String] {
        let parameters = ["term": query]

        let response: [String] = try await client.get(path: "/v0/autocomplete", parameters: parameters)

        return response
    }

    func detailedAutocomplete(query: String) async throws -> [Suggestion] {
        let parameters = ["term": query]

        let response: ResultsResponse<Suggestion> = try await client.get(path: "/v0/autocomplete-extra", parameters: parameters)

        return response.results
    }
}
