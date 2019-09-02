// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "my-first-controller",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.3.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.2"),
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.1")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "FluentMySQL"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)





