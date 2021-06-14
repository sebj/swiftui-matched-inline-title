
//  TextContent.swift
//  Copyright © 2021 Sebastian Jachec. All rights reserved.

import SwiftUI

enum TextContent {
    case string(String)
    case localizedString(key: LocalizedStringKey, tableName: String?, bundle: Bundle?, comment: StaticString?)
}

extension TextContent: Equatable {
    static func == (lhs: TextContent, rhs: TextContent) -> Bool {
        switch (lhs, rhs) {
        case let (.string(lString), .string(rString)):
            return lString == rString
        case let
                (.localizedString(lKey, lTableName, lBundle, lComment), .localizedString(rKey, rTableName, rBundle, rComment)):
            return lKey == rKey
                && lTableName == rTableName
                && lBundle == rBundle
                && "\(String(describing: lComment))" == "\(String(describing: rComment))"
        default:
            return false
        }
    }
}

extension TextContent {
    var view: Text {
        switch self {
        case let .string(value):
            return Text(value)
        case let .localizedString(key, tableName, bundle, comment):
            return Text(key, tableName: tableName, bundle: bundle, comment: comment)
        // TODO: AttributedString for iOS 15
        }
    }
}
