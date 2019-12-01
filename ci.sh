#!/bin/bash
set -e
xcodebuild -project 'Numerals.xcodeproj' -scheme 'Numerals' -destination 'platform=iOS Simulator,name=iPhone 8' test
xcodebuild -project 'Numerals.xcodeproj' -scheme 'Numerals' -destination 'generic/platform=iOS' -configuration Release build CODE_SIGNING_ALLOWED=NO
