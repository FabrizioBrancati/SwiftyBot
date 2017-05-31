import PackageDescription

let package = Package(
    name: "SwiftyBot",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/FabrizioBrancati/BFKit-Swift.git", majorVersion: 2, minor: 4)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests"
    ]
)
