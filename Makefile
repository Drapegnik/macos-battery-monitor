VERSION=0.1.0

.PHONY: install
install:
	brew install imagemagick
	brew install create-dmg

.PHONY: prepare-icons
prepare-icons:
	rm -rf ./dist/BatteryMonitor.iconset
	mkdir -p ./dist/BatteryMonitor.iconset
	sh ./bin/resize-icons.sh
	cd ./dist && iconutil -c icns BatteryMonitor.iconset

.PHONY: build-dmg
build-dmg:
	create-dmg \
		--volname "Battery Monitor Installer" \
		--window-pos 200 120 \
		--window-size 800 400 \
		--icon-size 100 \
		--icon "BatteryMonitor.app" 200 190 \
		--hide-extension "BatteryMonitor.app" \
		--app-drop-link 600 185 \
		"./dist/BatteryMonitor-$(VERSION)-Installer.dmg" \
		"./dist/BatteryMonitor-$(VERSION)"
