//
//  DefinitionsView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import SwiftUI

struct DefinitionsView: View {
    @Environment(\.viewFactory) private var viewFactory
    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Color.systemGrouppedBackground
                .ignoresSafeArea()

            ScrollView {
                LazyVGrid(columns: [.init(.flexible())], spacing: 16) {
                    ForEach(viewModel.words) { word in
                        WordView(word)
                    }

                    if viewModel.isMoreDataAvailable {
                        ActivityIndicatorView(isAnimating: .constant(true))
                            .frame(maxWidth: .infinity)
                            .onAppear {
                                viewModel.loadNextPage()
                            }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(viewModel.shouldUseCompactNavigation ? .inline : .automatic)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if viewModel.shouldShowSearch {
                    NavigationLink {
                        viewFactory.makeSearchView()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
        }
    }
}

struct DefinitionsView_Previews: PreviewProvider {
    static var previews: some View {
        DefinitionsView(viewModel: .init(contents: .wordsOfTheDay))
    }
}
