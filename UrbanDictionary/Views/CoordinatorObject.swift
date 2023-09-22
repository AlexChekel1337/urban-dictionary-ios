//
//  CoordinatorObject.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

private struct CoordinatorObjectEnvironmentKey: EnvironmentKey {
    static let defaultValue = CoordinatorObject()
}

extension EnvironmentValues {
    var coordinatorObject: CoordinatorObject {
        get { self[CoordinatorObjectEnvironmentKey.self] }
        set { self[CoordinatorObjectEnvironmentKey.self] = newValue }
    }
}

class CoordinatorObject: ObservableObject {
    @Published var navigationPath = NavigationPath()
}
