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
            url: "https://github.com/chrisob55/Embedded/releases/download/1.0.7/Foo.xcframework.zip",
            checksum: "bc221927bd7c0351225474200ebe9ba5b639195f0d89a046bd6328325ff19ff6"
        )
    ]
)
