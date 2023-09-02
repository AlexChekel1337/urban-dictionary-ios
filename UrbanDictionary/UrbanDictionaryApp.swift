//
//  UrbanDictionaryApp.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

@main
struct UrbanDictionaryApp: App {
    @Environment(\.viewFactory) private var viewFactory

    @State private var deepLinkUrl: URL?
    @State private var isDeepLinkViewPresented: Bool = false

    @State private var wordDefinition: Word?
    @State private var isDefinitionViewPresented: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack {
                    NavigationLink(isActive: $isDeepLinkViewPresented) {
                        if let deepLinkUrl {
                            viewFactory.makeViewForUrl(deepLinkUrl)
                        }
                    } label: {
                        EmptyView()
                    }

                    viewFactory.makeWordsOfTheDayView()
                }
            }
            .navigationViewStyle(.stack)
            .onOpenURL { url in
                deepLinkUrl = url
                showDeepLinkView()
            }
        }
    }

    private func showDeepLinkView() {
        let shouldWait = isDeepLinkViewPresented
        isDeepLinkViewPresented = false

        Task {
            if shouldWait {
                // If definition view was already presented, then
                // task should be delayed for some time to allow
                // pop animation to finish. If there's no delay,
                // pop animation will prevent app from presenting
                // this view again.
                try await Task.sleep(nanoseconds: 1_000_000_000 * 1)
            }

            isDeepLinkViewPresented.toggle()
        }
    }
}
