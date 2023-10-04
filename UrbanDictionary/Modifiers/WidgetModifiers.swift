//
//  WidgetModifiers.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 23.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI
import WidgetKit

extension View {
    /// Provides a background of the widget. Starting from iOS 17 system can remove
    /// widget's background depending on the context. This modifier does an availability check
    /// and sets background either using `.containerBackground(for: .widget) { ... }` when run
    /// on iOS 17 and later, or `.background` on iOS 16 and earlier.
    func widgetBackground(@ViewBuilder content: @escaping () -> some View) -> some View {
        if #available(iOS 17, *) {
            return self
                .containerBackground(for: .widget, content: content)
        } else {
            return self
                .background(content: content)
        }
    }
}
