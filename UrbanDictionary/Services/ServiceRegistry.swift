//
//  ServiceRegistry.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 02.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

private struct UrbanDictionaryServiceEnvironmentKey: EnvironmentKey {
    static let defaultValue = UrbanDictionaryService()
}

private struct PersistenceServiceEnvironmentKey: EnvironmentKey {
    static let defaultValue = PersistenceService.shared
}

extension EnvironmentValues {
    var urbanDictionaryService: UrbanDictionaryService {
        get { self[UrbanDictionaryServiceEnvironmentKey.self] }
        set { self[UrbanDictionaryServiceEnvironmentKey.self] = newValue }
    }

    var persistenceService: PersistenceService {
        get { self[PersistenceServiceEnvironmentKey.self] }
        set { self[PersistenceServiceEnvironmentKey.self] = newValue }
    }
}
