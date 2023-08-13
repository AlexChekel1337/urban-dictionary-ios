//
//  ViewFactory.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import SwiftUI

private struct ViewFactoryEnvironmentKey: EnvironmentKey {
    static let defaultValue = ViewFactory()
}

extension EnvironmentValues {
    var viewFactory: ViewFactory {
        get { self[ViewFactoryEnvironmentKey.self] }
        set { self[ViewFactoryEnvironmentKey.self] = newValue }
    }
}

class ViewFactory {
    @MainActor func makeViewForUrl(_ url: URL) -> some View {
        let defaultValue = AnyView(EmptyView())

        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return defaultValue
        }

        switch components.path {
            case "/define":
                guard let term = components.queryItems?.first(where: { $0.name == "term" })?.value else {
                    return defaultValue
                }

                let view = makeDefinitionsView(defining: term)
                return AnyView(view)
            default:
                return defaultValue
        }
    }

    @MainActor func makeWordsOfTheDayView() -> some View {
        let viewModel = DefinitionsView.ViewModel(contents: .wordsOfTheDay)
        let view = DefinitionsView(viewModel: viewModel)
        return view
    }

    @MainActor func makeDefinitionsView(defining term: String) -> some View {
        let viewModel = DefinitionsView.ViewModel(contents: .definitions(term: term))
        let view = DefinitionsView(viewModel: viewModel)
        return view
    }

    @MainActor func makeDefinitionView(showing word: Word) -> some View {
        let viewModel = DefinitionView.ViewModel(word: word)
        let view = DefinitionView(viewModel: viewModel)
        return view
    }

    @MainActor func makeSearchView() -> some View {
        let viewModel = SearchView.ViewModel()
        let view = SearchView(viewModel: viewModel)
        return view
    }
}
