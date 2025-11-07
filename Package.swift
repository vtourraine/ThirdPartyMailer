// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "ThirdPartyMailer",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(name: "ThirdPartyMailer", targets: ["ThirdPartyMailer"]),
    ],
    targets: [
        .target(
            name: "ThirdPartyMailer",
            dependencies: []),
        .testTarget(
            name: "ThirdPartyMailerTests",
            dependencies: ["ThirdPartyMailer"]),
    ]
)
