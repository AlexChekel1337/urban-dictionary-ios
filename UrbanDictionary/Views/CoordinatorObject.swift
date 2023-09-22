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

    func showDefinitions(of term: String) {
        let definableTerm = DefinableTerm(term: term)
        navigationPath.append(definableTerm)
    }

    func openUrl(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return
        }

        guard let scheme = components.scheme, scheme == "urbandictionary" else {
            return
        }

        switch components.path {
            case "/define":
                guard let term = components.queryItems?.first(where: { $0.name == "term" })?.value else {
                    return
                }

                let definableTerm = DefinableTerm(term: term)
                navigationPath.append(definableTerm)
            case "/definition":
                guard let id = components.queryItems?.first(where: { $0.name == "id" })?.value else {
                    return
                }

                let termIdentifier = TermIdentifier(id: id)
                navigationPath.append(termIdentifier)
            default:
                break
        }
    }
}
