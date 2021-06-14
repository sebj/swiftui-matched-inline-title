
//  ScrollView+MatchedInlineTitle.swift
//  Copyright © 2021 Sebastian Jachec. All rights reserved.

import SwiftUI

@available(iOS 14, *)
@available(watchOS, unavailable)
public extension ScrollView {
    
    /// Configures the inline navigation title for this view to match an existing `MatchedTitle` with the same `namespace`.
    /// - Parameter namespace: The namespace in which the title is defined. New
    ///     namespaces are created by adding an `@Namespace()` variable
    ///     to a ``View`` type and reading its value in the view's body
    ///     method.
    func matchedInlineTitle(in namespace: Namespace.ID) -> some View {
        _MatchedTitleContainer {
            self
                .coordinateSpace(name: namespace)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
