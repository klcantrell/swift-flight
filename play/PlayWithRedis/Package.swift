// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlayWithRedis",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/vapor/redis.git", from: "4.0.0-beta.6.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PlayWithRedis",
            dependencies: [
                .product(name: "Redis", package: "redis")
            ]
        ),
        .testTarget(
            name: "PlayWithRedisTests",
            dependencies: ["PlayWithRedis"]),
    ]
)
