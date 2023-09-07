// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-ethereum-rpc",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "EthereumRPC",
            targets: ["EthereumRPC"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kolyasev/SwiftJSONRPC.git", .upToNextMajor(from: "0.9.0")),
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
    ],
    targets: [
        .target(
            name: "EthereumRPC",
            dependencies: [
                .product(name: "SwiftJSONRPC", package: "SwiftJSONRPC"),
                .product(name: "BigInt", package: "BigInt"),
            ]
        ),
        .testTarget(
            name: "EthereumRPCTests",
            dependencies: ["EthereumRPC"]
        ),
    ]
)
