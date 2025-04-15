// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Foo",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Foo",
            targets: ["Foo"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Foo",
            url: "https://github.com/chrisob55/Embedded/releases/download/1.0.4/foo.xcframework.zip",
            checksum: "93a7eebbe7d6184a08655fcb7a3263ad4e692f62bd3d9fc0dd251a639eae8bec"
        )
    ]
)
