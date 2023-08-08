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

extension View {
    @ViewBuilder func shareSheet(sharing item: Any, isPresented: Binding<Bool>) -> some View {
        self.popover(isPresented: isPresented) {
            if #available(iOS 16, *) {
                ShareSheetViewRepresentable(activityItems: [item])
                    .ignoresSafeArea()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            } else {
                ShareSheetViewRepresentable(activityItems: [item])
                    .ignoresSafeArea()
            }
        }
    }
}
