import PackageDescription

let package = Package(
    name: "SwiftyBot",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 18)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)
