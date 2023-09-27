// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtendedUserDefaults",
    products: [
        .library(
            name: "ExtendedUserDefaults",
            targets: ["ExtendedUserDefaults"]
        ),
        .library(
            name: "ExtendedUserDefaultsRxExtension",
            type: .dynamic,
            targets: [
                "ExtendedUserDefaults",
                "ExtendedUserDefaultsRxExtension"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.6.0")
    ],
    targets: [
        .target(name: "ExtendedUserDefaults"),
        .target(
            name: "ExtendedUserDefaultsRxExtension",
            dependencies: [
                .target(name: "ExtendedUserDefaults"),
                .product(name: "RxSwift", package: "RxSwift"),
            ]
        ),
        .testTarget(
            name: "ExtendedUserDefaultsTests",
            dependencies: [
                "ExtendedUserDefaults",
                "ExtendedUserDefaultsRxExtension",
                .product(name: "RxBlocking", package: "RxSwift")
            ]
        ),
    ]
)
