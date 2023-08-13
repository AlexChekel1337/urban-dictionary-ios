//
//  UrbanDictionaryApp.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

// TODOs:
// - Opening definition view from a widget will only word once, until the definition view is dismissed

@main
struct UrbanDictionaryApp: App {
    @Environment(\.viewFactory) private var viewFactory

    @State private var wordDefinition: Word?
    @State private var isDefinitionViewPresented: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    NavigationLink(isActive: $isDefinitionViewPresented) {
                        if let wordDefinition {
                            viewFactory.makeDefinitionView(showing: wordDefinition)
                        }
                    } label: {
                        EmptyView()
                    }

                    viewFactory.makeWordsOfTheDayView()
                }
            }
            .onOpenURL { url in
                showWordView(from: url)
            }
        }
    }

    private func showWordView(from url: URL) {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            components.path == "/definition",
            let id = components.queryItems?.first(where: { $0.name == "id" })?.value
        else {
            print("Failed to process deeplink")
            return
        }

        Task {
            do {
                let service = UrbanDictionaryService()
                let word = try await service.definition(id: id)

                wordDefinition = word
                isDefinitionViewPresented = true
            } catch {
                print(error)
            }
        }
    }
}
