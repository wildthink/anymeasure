// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AnyMeasure",
    platforms: [.macOS(.v10_14), .iOS(.v10), .tvOS(.v10), .watchOS(.v6)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AnyMeasure",
            targets: ["AnyMeasure"]),
    ],
    dependencies: [
//        .package(url: "https://github.com/openalloc/SwiftCompactor.git", from: "1.3.0"),
        .package(url: "https://github.com/apple/swift-numerics", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AnyMeasure",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics"),
//                .product(name: "SwiftCompactor", package: "SwiftCompactor"),
            ]),
        .testTarget(
            name: "AnyMeasureTests",
            dependencies: ["AnyMeasure"]),
    ]
)
