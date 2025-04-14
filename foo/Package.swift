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
            url: "https://github.com/chrisob55/Embedded/releases/download/1.0.3/Foo.xcframework.zip",
            checksum: "a03a27e8ed0e8b8f94142c534f753f3e32c0d48ccbb1c550005bbc0fbee2bed9"
        )
    ]
)
