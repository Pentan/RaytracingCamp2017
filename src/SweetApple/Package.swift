// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "SweetApple",
    targets: [
        Target(name: "AppleBloom", dependencies: ["SweetAppleCore", "LinearAlgebra"]),
        Target(name: "SweetAppleCore", dependencies: ["LinearAlgebra"]),
        Target(name: "LinearAlgebra"),
    ],
    exclude: [
        "Sources/CBSD"
    ]
)
