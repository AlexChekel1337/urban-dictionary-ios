//
//  WordsOfTheDayView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 21.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct WordsOfTheDayView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(.flexible())], spacing: 16) {
                ForEach(viewModel.words) { word in
                    WordView(word)
                }

                if viewModel.hasError {
                    ErrorMessageView {
                        viewModel.retry()
                    }
                } else if viewModel.canLoad {
                    ActivityIndicatorView(isAnimating: .constant(true))
                        .task {
                            await viewModel.load()
                        }
                }
            }
            .padding()
        }
        .background(Color.systemGrouppedBackground)
        .navigationTitle("words_of_the_day_title")
    }
}

struct WordsOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        WordsOfTheDayView()
    }
}
