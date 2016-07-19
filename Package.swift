import PackageDescription

let package = Package(
    name: "SwiftyBot",
    dependencies: [
        .Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0, minor: 14),
        .Package(url: "https://github.com/qutheory/vapor-mustache.git", majorVersion: 0, minor: 10)
        .Package(url: "https://github.com/qutheory/vapor-tls.git", majorVersion: 0, minor: 3)
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
