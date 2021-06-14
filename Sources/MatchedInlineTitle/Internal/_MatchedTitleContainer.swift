
//  _MatchedTitleContainer.swift
//  Copyright © 2021 Sebastian Jachec. All rights reserved.

import SwiftUI

struct _MatchedTitleContainer<Content>: View where Content: View {
    
    @State private var title: TextContent?
    @State private var isVisible = false
    private let content: () -> Content
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
            .onPreferenceChange(_TitlePreferenceKey.self) { data in
                title = data?.title
                isVisible = data?.isVisible ?? false
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    title.map(\.view)
                        .lineLimit(1)
                        .accessibilityAddTraits(.isHeader)
                        .opacity(isVisible ? 1 : 0)
                }
            }
    }
}
