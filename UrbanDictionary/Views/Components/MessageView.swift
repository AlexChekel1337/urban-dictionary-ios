//
//  MessageView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 29.08.2023.
//

import SwiftUI

struct MessageView: View {
    private let tapHandler: () -> Void

    init(tapHandler: @escaping () -> Void) {
        self.tapHandler = tapHandler
    }

    var body: some View {
        VStack {
            Text("⚠️")
                .font(.largeTitle)
            Text("An error occurred!")
                .foregroundColor(.secondary)
            Button("Retry") {
                tapHandler()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView { }
    }
}
