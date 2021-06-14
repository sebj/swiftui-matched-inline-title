
//  MatchedTitle.swift
//  Copyright © 2021 Sebastian Jachec. All rights reserved.

import SwiftUI

@available(iOS 14, *)
@available(watchOS, unavailable)
public struct MatchedTitle<Content>: View where Content: View {
    
    private let textContent: TextContent
    private let namespace: Namespace.ID
    private let content: (Text) -> Content
    
    /// Creates a title view that displays a stored string without localization.
    ///
    /// - Parameters:
    ///   - string: The string value to display without localization.
    ///   - namespace: The namespace in which the title is defined. New namespaces are created by adding an `@Namespace()` variable
    ///     to a ``View`` type and reading its value in the view's body method.
    ///   - content: A closure to customise the `Text`.
    public init<S>(
        _ string: S,
        namespace: Namespace.ID,
        @ViewBuilder _ content: @escaping (Text) -> Content) where S: StringProtocol
    {
        self.textContent = .string(String(string))
        self.namespace = namespace
        self.content = content
    }
    
    /// Creates a title view that displays a string literal without localization.
    ///
    /// - Parameters:
    ///   - string: A string to display without localization.
    ///   - namespace: The namespace in which the title is defined. New namespaces are created by adding an `@Namespace()` variable
    ///     to a ``View`` type and reading its value in the view's body method.
    ///   - content: A closure to customise the `Text`.
    public init(
        verbatim string: String,
        namespace: Namespace.ID,
        @ViewBuilder _ content: @escaping (Text) -> Content)
    {
        self.textContent = .string(string)
        self.namespace = namespace
        self.content = content
    }
    
    /// Creates a title view that displays localized content identified by a key.
    /// - Parameters:
    ///   - key: The key for a string in the table identified by `tableName`.
    ///   - tableName: The name of the string table to search. If `nil`, use the
    ///     table in the `Localizable.strings` file.
    ///   - bundle: The bundle containing the strings file. If `nil`, use the
    ///     main bundle.
    ///   - comment: Contextual information about this key-value pair.
    ///   - namespace: The namespace in which the title is defined. New namespaces are created by adding an `@Namespace()` variable
    ///     to a ``View`` type and reading its value in the view's body method.
    ///   - content: A closure to customise the `Text`.
    public init(
        _ key: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil,
        namespace: Namespace.ID,
        @ViewBuilder _ content: @escaping (Text) -> Content)
    {
        self.textContent = .localizedString(key: key, tableName: tableName, bundle: bundle, comment: comment)
        self.namespace = namespace
        self.content = content
    }
    
    public var body: some View {
        content(textContent.view)
            .overlay(
                GeometryReader { geometry in
                    let frame = geometry.frame(in: .named(namespace))
                    
                    Color.clear
                        .hidden()
                        .preference(
                            key: _TitlePreferenceKey.self,
                            value: _TitlePreferenceData(
                                title: self.textContent,
                                isVisible: -frame.origin.y > frame.height))
                }
            )
    }
}

public extension MatchedTitle where Content == Text {
    
    init<S>(_ string: S, namespace: Namespace.ID) where S: StringProtocol {
        self.init(string, namespace: namespace) { $0 }
    }
    
    init(verbatim string: String, namespace: Namespace.ID) {
        self.init(verbatim: string, namespace: namespace) { $0 }
    }
    
    init(
        _ key: LocalizedStringKey,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil,
        namespace: Namespace.ID)
    {
        self.init(
            key,
            tableName: tableName,
            bundle: bundle,
            comment: comment,
            namespace: namespace)
        {
            $0
        }
    }
}
