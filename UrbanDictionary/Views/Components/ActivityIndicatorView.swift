//
//  ActivityIndicatorView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 07.08.2023.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var isAnimating: Bool

    func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let uiActivityIndicatorView = uiView as? UIActivityIndicatorView
        isAnimating ? uiActivityIndicatorView?.startAnimating() : uiActivityIndicatorView?.stopAnimating()
    }
}
