//
//  UrbanDictionaryApp.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

// TODOs:
// - Change search algorithms to instantly update the contents and throttle the requests

@main
struct UrbanDictionaryApp: App {
    private let viewFactory = ViewFactory()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                viewFactory.makeWordsOfTheDayView()
                    .environment(\.viewFactory, viewFactory)
            }
        }
    }
}
