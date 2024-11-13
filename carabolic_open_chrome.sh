#!/usr/bin/env bash

# Open Chrome and go to Google
# Usage: carabolic_open_chrome.sh "Window Name"
open -na "Google Chrome" --args --window-name="$1" --new-window "https://www.google.com"
