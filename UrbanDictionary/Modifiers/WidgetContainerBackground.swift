//
//  WidgetContainerBackground.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 22.09.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import SwiftUI
import WidgetKit

extension View {
    @ViewBuilder
    func widgetContainerBackground(@ViewBuilder content: () -> some View) -> some View {
        if #available(iOS 17, *) {
            self.containerBackground(for: .widget) {
                content()
            }
        } else {
            self
        }
    }
}
