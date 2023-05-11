#!/bin/bash

clear_dock() {
    defaults delete com.apple.dock persistent-apps
}

add_dock_shortcuts() {
    while IFS= read -r line
    do
       defaults write com.apple.dock persistent-apps -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>$line</string>
                        <key>_CFURLStringType</key>
                        <integer>0</integer>
                    </dict>
                </dict>
            </dict>"
    done
}

clear_dock
add_dock_shortcuts

killall Dock

