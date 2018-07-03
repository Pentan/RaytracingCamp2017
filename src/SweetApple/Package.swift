// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SweetApple",
    targets: [
        .target(
            name: "AppleBloom",
            dependencies: ["SweetAppleCore", "LinearAlgebra"]),
        .target(
            name: "SweetAppleCore",
            dependencies: ["LinearAlgebra"]),
        .target(
            name: "LinearAlgebra"),
        
        .testTarget(
            name: "LinearAlgebraTests",
            dependencies: ["LinearAlgebra"]),
        .testTarget(
            name: "SweetAppleCoreTests",
            dependencies: ["SweetAppleCore", "LinearAlgebra"]),
    ],
    swiftLanguageVersions: [4]
    /*,
    exclude: [
        "Sources/CBSD"
    ]
 */
)
