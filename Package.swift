// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-ethereum-rpc",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "swift-ethereum-rpc",
            targets: ["swift-ethereum-rpc"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kolyasev/SwiftJSONRPC.git", .upToNextMajor(from: "0.9.0")),
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
    ],
    targets: [
        .target(
            name: "swift-ethereum-rpc",
            dependencies: [
                .product(name: "SwiftJSONRPC", package: "SwiftJSONRPC"),
                .product(name: "BigInt", package: "BigInt"),
            ]
        ),
        .testTarget(
            name: "swift-ethereum-rpc-tests",
            dependencies: ["swift-ethereum-rpc"]
        ),
    ]
)
