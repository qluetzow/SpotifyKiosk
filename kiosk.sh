#!/bin/sh

KIOSK_URL="https://play.spotify.com/"
ERROR_URL="http://localhost:8080"


echo 'Starting Chromium...'
/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk --app=$KIOSK_URL&

while true; do
    sleep 15s
    STATUS=$(ping -W 5 -c 1 one.one.one.one | grep -oE "[0-9]{1,3} packet loss")

    if [ "$STATUS" == "100% packet loss" ]; then                 #!= "200" ]; then
        echo "Network issue detected, killing kiosk."
        killall chromium
        /usr/bin/chromium-browser  --noerrdialogs --disable-infobars --kiosk --app=$ERROR_URL
        exit 1
    fi
done
