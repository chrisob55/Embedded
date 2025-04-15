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
            url: "https://github.com/chrisob55/Embedded/releases/download/1.0.6/Foo.xcframework.zip",
            checksum: "1bb14c53c2e90f14082f0eed103d360adef0764f56bce6dc8183b0e8b87b9c3e"
        )
    ]
)
