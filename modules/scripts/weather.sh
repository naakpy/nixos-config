#!/usr/bin/env bash

# Define the location as Paris
LOC="48.8566,2.3522" # Latitude and Longitude for Paris

# Fetch the weather information
text="$(curl -s "https://wttr.in/$LOC?format=1" | sed 's/ //g')"
tooltip="$(curl -s "https://wttr.in/$LOC?0QT" |
    sed 's/\\/\\\\/g' |
    sed ':a;N;$!ba;s/\n/\\n/g' |
    sed 's/"/\\"/g')"

# Check if the weather data is valid and print the JSON output
if ! grep -q "Unknown location" <<< "$text"; then
    echo "{\"text\": \"$text\", \"tooltip\": \"<tt>$tooltip</tt>\", \"class\": \"weather\"}"
fi
