//
//  UrbanDictionaryLinkTransformer.swift
//  UrbanDictionary
//
//  Created by Alexander Chekel on 11.08.2023.
//

import Foundation

enum UrbanDictionaryLinkTransformer {
    static func transform(from string: String) throws -> String {
        var mutableString = string

        let regularExpression = try NSRegularExpression(pattern: #"\[(.*?)\]"#)
        let matches = regularExpression.matches(in: string, range: NSRange(string.startIndex..., in: string))

        for match in matches {
            let stringRange = match.range(at: 0)
            let groupRange = match.range(at: 1)

            let nsString = string as NSString
            let matchingString = nsString.substring(with: stringRange)
            let matchingGroup = nsString.substring(with: groupRange)

            let encodedQuery = matchingGroup.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? matchingGroup
            let urlString = "urbandictionary:///define?term=" + encodedQuery
            let replacementString = "[\(matchingGroup)](\(urlString))"
            mutableString = mutableString.replacingOccurrences(of: matchingString, with: replacementString)
        }

        return mutableString
    }
}
