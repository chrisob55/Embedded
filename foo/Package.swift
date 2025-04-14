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
            url: "https://github.com/chrisob55/Embedded/releases/download/1.0.2/Foo.xcframework.zip",
            checksum: "3eb0c1ddc8f47bd87372860ce07aa5f9c5b249a304e763af695e6c8416964a9b"
        )
    ]
)
