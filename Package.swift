// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftyBot",
    products: [
        .executable(name: "SwiftyBot", targets: ["SwiftyBot"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMinor(from: "2.2.2")),
        .package(url: "https://github.com/FabrizioBrancati/BFKit-Swift.git", .branch("swift-4"))
    ],
    targets: [
        .target(name: "SwiftyBot", dependencies: ["Vapor", "BFKit"])
    ]
)
