//
//  WidgetPadding.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI

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
}
