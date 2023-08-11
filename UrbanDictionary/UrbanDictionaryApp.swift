//
//  UrbanDictionaryApp.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

// TODOs:
// - Look into wrong definition urls. Defining "red apple" will result in empty screen.
// - Change search algorithms to instantly update the contents and throttle the requests

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
