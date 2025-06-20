#!/bin/sh

KIOSK_URL="https://play.spotify.com/"
ERROR_URL="http://localhost:8080"


echo 'Starting Chromium...'
/usr/bin/chromium-browser --noerrdialogs --disable-infobars --kiosk --app=$KIOSK_URL&

while true; do
    sleep 15s
    STATUS=$(curl --max-time 5 -I https://www.google.com -o /dev/null -w '%{http_code}')

    if [ "$STATUS" != "200" ]; then
        echo "Network issue detected, killing kiosk."
        killall chromium
        /usr/bin/chromium-browser  --noerrdialogs --disable-infobars --kiosk --app=$ERROR_URL
        exit 1
    fi
done

