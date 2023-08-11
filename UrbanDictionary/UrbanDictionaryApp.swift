//
//  UrbanDictionaryApp.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

// TODOs:
// - Look into wrong definition urls. Defining "red apple" will result in empty screen.

@main
struct UrbanDictionaryApp: App {
    @Environment(\.viewFactory) private var viewFactory

    var body: some Scene {
        WindowGroup {
            NavigationView {
                viewFactory.makeWordsOfTheDayView()
            }
        }
    }
}
