#!/bin/bash

ORIGINAL="./assets/BatteryIcon.png"
DIST="./dist/BatteryMonitor.iconset"

# Regular sizes
for size in 16 32 64 128 256 512; do
    magick "$ORIGINAL" -resize ${size}x${size} "$DIST/icon_${size}x${size}.png"
done

# @2x sizes
for size in 16 32 64 128 256 512; do
    magick "$ORIGINAL" -resize $((size*2))x$((size*2)) "$DIST/icon_${size}x${size}@2x.png"
done
