//
//  URL+StaticString.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//

import Foundation

extension URL {
    static let nonExistentUrl: URL = .init(staticString: "https://nonexistenturl.xyz")

    init(staticString: StaticString) {
        self.init(string: "\(staticString)")!
    }
}
