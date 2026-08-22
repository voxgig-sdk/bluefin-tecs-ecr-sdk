// swift-tools-version:5.9
//
// BluefinTecsEcr SDK - SwiftPM manifest. The runtime itself is dependency-free
// (Foundation + the vendored Voxgig Struct port under
// Sources/ProjectNameSDK/Struct); declared feature/target deps (if any)
// appear below.
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
