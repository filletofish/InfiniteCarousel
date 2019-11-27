// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfiniteCarousel",
    platforms: [
        .iOS(.v11),.tvOS(.v11)
    ],
    products: [
        .library(
            name: "InfiniteCarousel",
            targets: ["InfiniteCarousel"]),
    ],
    targets: [
        .target(
            name: "InfiniteCarousel",
            dependencies: []),
        .testTarget(
            name: "InfiniteCarouselTests",
            dependencies: ["InfiniteCarousel"]),
    ]
)
