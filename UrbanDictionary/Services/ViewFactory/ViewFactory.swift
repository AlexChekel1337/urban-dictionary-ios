//
//  ViewFactory.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import SwiftUI

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
            case "/definition":
                guard let id = components.queryItems?.first(where: { $0.name == "id" })?.value else {
                    return defaultValue
                }

                let view = makeDefinitionView(definitionId: id)
                return AnyView(view)
            default:
                return defaultValue
        }
    }

    @MainActor func makeWordsOfTheDayView() -> some View {
        let viewModel = DefinitionListView.ViewModel(content: .wordsOfTheDay)
        let view = DefinitionListView(viewModel: viewModel)
        return view
    }

    @MainActor func makeDefinitionsView(defining term: String) -> some View {
        let viewModel = DefinitionListView.ViewModel(content: .definitions(term: term))
        let view = DefinitionListView(viewModel: viewModel)
        return view
    }

    @MainActor func makeDefinitionView(definitionId: String) -> some View {
        let viewModel = DefinitionListView.ViewModel(content: .definition(id: definitionId))
        let view = DefinitionListView(viewModel: viewModel)
        return view
    }
}
