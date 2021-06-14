// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "swiftui-matched-inline-title",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "MatchedInlineTitle",
            targets: ["MatchedInlineTitle"]),
    ],
    targets: [
        .target(
            name: "MatchedInlineTitle",
            dependencies: [])
    ]
)
