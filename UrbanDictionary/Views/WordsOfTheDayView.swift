//
//  WordsOfTheDayView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

struct WordsOfTheDayView: View {
    @StateObject private var viewModel = ViewModel()

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
        .navigationTitle("Words of the day")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SearchView()
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}

struct WordsOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WordsOfTheDayView()
        }
    }
}
