// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "BaseAPI",
    products: [
        .library(name: "BaseAPI", targets: ["BaseAPI"])
        ],
    dependencies: [],
    targets: [
        .target(name: "BaseAPI", dependencies: [], path: "BaseAPI/Classes")
    ]
)
