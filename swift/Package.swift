// swift-tools-version:5.9
//
// BluefinTecsEcr SDK - SwiftPM manifest. Zero runtime dependencies (Foundation +
// the vendored Voxgig Struct port under Sources/ProjectNameSDK/Struct).
import PackageDescription

let package = Package(
    name: "BluefinTecsEcrSdk",
    products: [
        .library(name: "BluefinTecsEcrSdk", targets: ["BluefinTecsEcrSdk"]),
    ],
    targets: [
        .target(
            name: "BluefinTecsEcrSdk",
            path: "Sources/ProjectNameSDK"),
        .testTarget(
            name: "BluefinTecsEcrSdkTests",
            dependencies: ["BluefinTecsEcrSdk"],
            path: "Tests/ProjectNameSDKTests"),
    ]
)
