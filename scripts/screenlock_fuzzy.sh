#!/bin/sh -e

# Take a screenshot
test -f /tmp/screen_locked.png && rm /tmp/screen_locked.png
scrot /tmp/screen_locked.png

# Pixellate it 10x
# requires imagemagick
mogrify -scale 10% -scale 1000% /tmp/screen_locked.png

# Lock screen displaying this image.
i3lock -i /tmp/screen_locked.png -n -c 000000

# Turn the screen off after a delay.
sleep 60; pgrep i3lock && xset dpms force off
