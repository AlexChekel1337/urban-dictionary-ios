//
//  HTTPClient.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import Foundation

enum HTTPClientError: Error {
    case invalidUrl
}

class HTTPClient {
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func get<T:Decodable>(path: String, parameters: [String: String] = [:]) async throws -> T {
        guard var components = URLComponents(string: baseUrl + path) else {
            throw HTTPClientError.invalidUrl
        }

        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }

        guard let url = components.url else {
            throw HTTPClientError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }
}
