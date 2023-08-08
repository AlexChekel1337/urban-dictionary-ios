//
//  UrbanDictionaryApp.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

// TODOs:
// - Repurpose WordsOfTheDayView into DefinitionsView to make it reusable in search
// - Change search algorithms to instantly update the contents and throttle the requests

@main
struct UrbanDictionaryApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WordsOfTheDayView()
            }
        }
    }
}
