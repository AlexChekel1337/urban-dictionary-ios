//
//  HTTPClient.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import Foundation

enum HTTPClientError: Error {
    case invalidUrl
}

class HTTPClient {
    private let baseUrl: String
    private let urlSession: URLSession

    init(baseUrl: String) {
        self.baseUrl = baseUrl

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Accept": "application/json"]

        self.urlSession = URLSession(configuration: configuration)
    }

    func get<T: Decodable>(path: String, parameters: [String: String] = [:]) async throws -> T {
        guard var components = URLComponents(string: baseUrl + path) else {
            throw HTTPClientError.invalidUrl
        }

        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }

        guard let url = components.url else {
            throw HTTPClientError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await urlSession.data(for: request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }
}
