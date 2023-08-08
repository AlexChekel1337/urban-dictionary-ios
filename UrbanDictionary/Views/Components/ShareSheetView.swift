//
//  ShareSheetView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import SwiftUI

private struct ShareSheetViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController

    private let activityItems: [Any]

    init(activityItems: [Any]) {
        self.activityItems = activityItems
    }

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let viewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Nothing to update here
    }
}

struct ShareSheetView: View {
    private let item: Any

    init(sharing item: Any) {
        self.item = item
    }

    var body: some View {
        ShareSheetViewRepresentable(activityItems: [item])
            .ignoresSafeArea()
    }
}
