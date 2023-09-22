//
//  Suggestion.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 08.08.2023.
//  Copyright © 2023 Alexander Chekel. All rights reserved.
//

import Foundation

struct Suggestion: Hashable, Codable {
    let term: String
    let preview: String
}
