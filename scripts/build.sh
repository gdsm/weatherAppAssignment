#!/bin/bash

SIMULATOR='platform=iOS Simulator,name=iPhone 15'

pod install

xcodebuild \
	-workspace WeatherApp.xcworkspace \
	-scheme WeatherApp \
	-destination "$SIMULATOR" \
	-derivedDataPath ../../derivedData \
	clean build

