//
//  CoordinatorView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 21.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinatorObject = CoordinatorObject()

    var body: some View {
        NavigationStack(path: $coordinatorObject.navigationPath) {
            WordsOfTheDayView()
                .environment(\.coordinatorObject, coordinatorObject)
                .navigationDestination(for: DefinableTerm.self) { definableTerm in
                    DefinitionsView(definableTerm: definableTerm)
                }
        }
    }
}

#Preview {
    CoordinatorView()
}
