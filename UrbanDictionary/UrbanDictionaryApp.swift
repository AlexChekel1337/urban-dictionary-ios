//
//  UrbanDictionaryApp.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

// TODOs:
// - Fix old icon being displayed at lower resolutions
// - Favorite definitions (saved locally???)
// - iPad and/or macOS support

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

        let shouldWait = isDefinitionViewPresented
        isDefinitionViewPresented = false

        Task {
            do {
                let service = UrbanDictionaryService()
                let word = try await service.definition(id: id)

                if shouldWait {
                    // If definition view was already presented, then
                    // task should be delayed for some time to allow
                    // pop animation to finish. If there's no delay,
                    // pop animation will prevent app from presenting
                    // this view again.
                    try await Task.sleep(nanoseconds: 1_000_000_000 * 1)
                }

                wordDefinition = word
                isDefinitionViewPresented = true
            } catch {
                print(error)
            }
        }
    }
}
