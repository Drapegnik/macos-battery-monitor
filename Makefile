VERSION=0.1-alpha.2

.PHONY: install
install:
	brew install imagemagick

.PHONY: prepare-icons
prepare-icons:
	rm -rf ./dist/BatteryMonitor.iconset
	mkdir -p ./dist/BatteryMonitor.iconset
	sh ./bin/resize-icons.sh
	cd ./dist && iconutil -c icns BatteryMonitor.iconset

.PHONY: build-dmg
build-dmg:
	hdiutil create -fs HFS+ -srcfolder ./dist/BatteryMonitor-$(VERSION) -volname "Battery Monitor" ./dist/BatteryMonitor-$(VERSION).dmg
