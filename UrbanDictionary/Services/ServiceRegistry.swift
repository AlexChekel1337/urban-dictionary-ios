//
//  ServiceRegistry.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 02.09.2023.
//

import SwiftUI

private struct ViewFactoryEnvironmentKey: EnvironmentKey {
    static let defaultValue = ViewFactory()
}

private struct UrbanDictionaryServiceEnvironmentKey: EnvironmentKey {
    static let defaultValue = UrbanDictionaryService()
}

private struct PersistenceServiceEnvironmentKey: EnvironmentKey {
    static let defaultValue = PersistenceService.shared
}

extension EnvironmentValues {
    var viewFactory: ViewFactory {
        get { self[ViewFactoryEnvironmentKey.self] }
        set { self[ViewFactoryEnvironmentKey.self] = newValue }
    }

    var urbanDictionaryService: UrbanDictionaryService {
        get { self[UrbanDictionaryServiceEnvironmentKey.self] }
        set { self[UrbanDictionaryServiceEnvironmentKey.self] = newValue }
    }

    var persistenceService: PersistenceService {
        get { self[PersistenceServiceEnvironmentKey.self] }
        set { self[PersistenceServiceEnvironmentKey.self] = newValue }
    }
}
