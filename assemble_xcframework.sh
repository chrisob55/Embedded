#!/usr/bin/env bash
if ./gradlew assembleFooXCFramework; then
    DIRECTORY="swiftpm"
    ZIP="Foo.xcframework.zip"
    if [ -d "$DIRECTORY" ]; then
      rm -rf $DIRECTORY
    fi
    if [ -f "$ZIP" ]; then
      rm $ZIP
    fi
    mkdir $DIRECTORY
    echo "INFO: Copying artifact"
    cp -r foo/build/XCFrameworks/release/Foo.xcframework $DIRECTORY
    echo "INFO: Zipping"
    cd $DIRECTORY
    zip -r $ZIP .
    if CHECK_SUM=$(swift package compute-checksum Foo.xcframework.zip); then
      echo "INFO: $(date +'%c') - Updating Package.swift with checksum ${CHECK_SUM}"
      sed -i .bak "s/checksum.*/checksum: \"${CHECK_SUM}\"/g" ../Package.swift
      sed -i .bak \
      "s/url: \"https:\/\/github.com\/chrisob55\/Embedded\/releases.*/url: \"https\:\/\/github.com\/chrisob55\/Embedded\/releases\/download\/1.0.7\/Foo.xcframework.zip\",/g" \
      ../Package.swift
    else
      echo "ERROR: $(date +'%c') - Failed to create checksum"
    fi
else
      echo "ERROR: $(date +'%c') - Build failed"
fi
