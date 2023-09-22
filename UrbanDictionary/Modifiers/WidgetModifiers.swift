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
    /// iOS 17 automatically adds brand new content margin
    /// to widget's body based on its environment. This
    /// modifier adds a padding on older versions of iOS.
    @ViewBuilder
    func applyingWidgetPadding() -> some View {
        if #unavailable(iOS 17) {
            self.padding()
        } else {
            self
        }
    }

    /// A `.containerBackground(for: .widget)` modifier wrapper
    /// with iOS availability check. Does notihing on iOS versions
    /// prior to 17.
    @ViewBuilder
    func applyingDefaultWidgetBackground() -> some View {
        if #available(iOS 17, *) {
            self.containerBackground(for: .widget) {}
        } else {
            self
        }
    }
}
