// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "BaseAPI",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v9),
        .watchOS(.v2),
        .tvOS(.v9)
    ],
    products: [
        .library(name: "BaseAPI", targets: ["BaseAPI"])
    ],
    dependencies: [],
    targets: [
        .target(name: "BaseAPI", dependencies: [], path: "BaseAPI/Classes")
    ]
)
