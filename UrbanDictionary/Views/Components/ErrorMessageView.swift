//
//  ErrorMessageView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 21.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct ErrorMessageView: View {
    var retryHandler: () -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.secondarySystemGrouppedBackground)
                .cornerRadius(16)

            HStack(alignment: .center) {
                Text("⚠️")
                    .font(.largeTitle)

                VStack {
                    Text("error_loading_title")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("error_loading_text")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Button {
                    retryHandler()
                } label: {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .imageScale(.large)
                }
            }
            .padding()
        }
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ErrorMessageView {
                print("Retry!")
            }
            .padding()
        }
        .background(Color.systemGrouppedBackground)
    }
}
