// swift-tools-version: 5.10.0

import PackageDescription

let package = Package(
    name: "LayoutUIKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "LayoutUIKit", targets: ["LayoutUIKit"]),
    ],
    targets: [
        .target(name: "LayoutUIKit"),
        .testTarget(name: "LayoutUIKitTests", dependencies: ["LayoutUIKit"])
    ]
)
