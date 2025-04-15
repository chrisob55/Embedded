#!/usr/bin/env bash
if ./gradlew :foo:assembleXCFramework; then
    DIRECTORY="swiftpm"
    ZIP="foo.xcframework.zip"
    if [ -d "$DIRECTORY" ]; then
      rm -rf $DIRECTORY
    fi
    if [ -f "$ZIP" ]; then
      rm $ZIP
    fi
    mkdir $DIRECTORY
    echo "INFO: Copying artifact"
    cp -r foo/build/XCFrameworks/release/foo.xcframework $DIRECTORY
    echo "INFO: Zipping"
    cd $DIRECTORY
    zip -r $ZIP .
    if CHECK_SUM=$(swift package compute-checksum foo.xcframework.zip); then
      echo "INFO: $(date +'%c') - Updating Package.swift with checksum ${CHECK_SUM}"
      sed -i .bak "s/checksum.*/checksum: \"${CHECK_SUM}\"/g" ../Package.swift
      sed -i .bak \
      "s/url: \"https:\/\/github.com\/chrisob55\/Embedded\/releases.*/url: \"https\:\/\/github.com\/chrisob55\/Embedded\/releases\/download\/1.0.4\/foo.xcframework.zip\",/g" \
      ../Package.swift
    else
      echo "ERROR: $(date +'%c') - Failed to create checksum"
    fi
else
      echo "ERROR: $(date +'%c') - Build failed"
fi
