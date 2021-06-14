
//  _TitlePreferenceKey.swift
//  Copyright © 2021 Sebastian Jachec. All rights reserved.

import SwiftUI

struct _TitlePreferenceData: Equatable {
    let title: TextContent
    let isVisible: Bool
}

struct _TitlePreferenceKey: PreferenceKey {
    
    typealias Value = _TitlePreferenceData?

    static var defaultValue: _TitlePreferenceData?

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
