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

    @MainActor func makeSearchView() -> some View {
        let viewModel = SearchView.ViewModel()
        let view = SearchView(viewModel: viewModel)
        return view
    }
}
