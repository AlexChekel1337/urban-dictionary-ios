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

    func openUrl(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            assertionFailure("Failed to construct URLComponents from \(url.absoluteString)")
            return
        }

        guard let scheme = components.scheme, scheme == "urbandictionary" else {
            assertionFailure("Unexpected url scheme")
            return
        }

        switch components.path {
            case "/define":
                if let term = components.queryItems?.first(where: { $0.name == "term" })?.value {
                    let definableTerm = DefinableTerm(term: term)
                    navigationPath.append(definableTerm)
                } else {
                    assertionFailure("Url for '/define' path does not contain required 'term' or 'id' query parameters")
                }
            default:
                break
        }
    }
}
