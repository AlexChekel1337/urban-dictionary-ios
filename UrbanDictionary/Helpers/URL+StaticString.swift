//
//  URL+StaticString.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import Foundation

extension URL {
    init(staticString: StaticString) {
        self.init(string: "\(staticString)")!
    }
}
