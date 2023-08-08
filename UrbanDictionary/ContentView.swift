//
//  ContentView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

struct ContentView: View {
    let text: String = #"<a href="https://google.com">Google</a>"#

    var body: some View {
        VStack {
            Text(text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
