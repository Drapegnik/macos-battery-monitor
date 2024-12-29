VERSION=0.1-alpha

.PHONY: build-dmg
build-dmg:
	hdiutil create -fs HFS+ -srcfolder ./dist/BatteryMonitor-$(VERSION) -volname "Battery Monitor" ./dist/BatteryMonitor-$(VERSION).dmg
