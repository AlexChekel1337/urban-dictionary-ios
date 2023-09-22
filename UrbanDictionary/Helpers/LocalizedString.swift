//
//  LocalizedString.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 19.08.2023.
//

import Foundation

func LocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func LocalizedString(_ key: String, arguments: CVarArg...) -> String {
    let templateString = LocalizedString(key)
    return String(format: templateString, arguments: arguments)
}
