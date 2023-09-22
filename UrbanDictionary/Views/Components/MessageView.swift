//
//  MessageView.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 29.08.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    enum Kind {
        case error
        case notFound
        case custom(emoji: String)
    }

    private let kind: Kind
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey?
    private let actionButtonTitle: LocalizedStringKey?
    private let actionHandler: (() -> Void)?

    init(
        kind: Kind,
        title: LocalizedStringKey,
        text: LocalizedStringKey? = nil,
        actionButtonTitle: LocalizedStringKey? = nil,
        actionHandler: (() -> Void)? = nil
    ) {
        self.kind = kind
        self.title = title
        self.text = text
        self.actionButtonTitle = actionButtonTitle
        self.actionHandler = actionHandler
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(kind.emoji)
                .font(.largeTitle)

            VStack {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)

                if let text {
                    Text(text)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }

            if let actionButtonTitle {
                Button(actionButtonTitle) {
                    actionHandler?()
                }
            }
        }
        .padding()
    }
}

private extension MessageView.Kind {
    var emoji: String {
        switch self {
            case .error:
                return "⚠️"
            case .notFound:
                return "🤷"
            case .custom(let emoji):
                return emoji
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageView(
                kind: .error,
                title: "Something went wrong",
                text: "An error occurred while loading the data",
                actionButtonTitle: "Retry"
            )
            .previewDisplayName("Error")

            MessageView(
                kind: .notFound,
                title: "Nothing found",
                text: "Consider trying a different search request"
            )
            .previewDisplayName("Not Found")

            MessageView(
                kind: .custom(emoji: "🪵"),
                title: "This is an example logging message title",
                text: "This is an example logging message text",
                actionButtonTitle: "Continue"
            )
            .previewDisplayName("Custom")
        }
    }
}
