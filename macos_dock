#!/usr/bin/env bash

# Apply by running 'source macos_dock'
# Customize to your convenience

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/System Preferences.app"
dockutil --no-restart --add "/Applications/Spark.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Atom.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/Adobe Photoshop CC 2018.app"
dockutil --no-restart --add "/Applications/Adobe Lightroom Classic CC.app"

killall Dock

# If you have trouble with icons appearing as generic placeholders, try running
# the following commands.

# sudo rm -rfv /Library/Caches/com.apple.iconservices.store
# sudo find /private/var/folders/ \( -name com.apple.dock.iconcache -or -name com.apple.iconservices \) -exec rm -rfv {} \;
# sleep 3;
# sudo touch /Applications/*
# killall Dock
# killall Finder

# Reference:
# - https://gist.github.com/fabiofl/5873100
# - https://www.hackintosh.blog/article/24/rebuild-icon-cache-macos/
