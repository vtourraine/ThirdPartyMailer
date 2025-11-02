// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ThirdPartyMailer",
    platforms: [.iOS(.v10), .macOS(.v10_13)],
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
