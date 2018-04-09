// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SweetApple",
    targets: [
        .target(name: "AppleBloom", dependencies: ["SweetAppleCore", "LinearAlgebra"]),
        .target(name: "SweetAppleCore", dependencies: ["LinearAlgebra"]),
        .target(name: "LinearAlgebra"),
    ],
    swiftLanguageVersions: [4]
    /*,
    exclude: [
        "Sources/CBSD"
    ]
 */
)
