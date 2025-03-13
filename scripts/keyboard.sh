#!/usr/bin/env sh

# Keyboard speed
xset r rate 200 30

# Init FN+KEYS
if pgrep -x "xbindkeys" > /dev/null; then pkill xbindkeys; fi
xbindkeys --poll-rc

# Keyboard layout, layout trigger & CAPS lock to CTRL
setxkbmap -layout us,ru -option grp:toggle,ctrl:nocaps

# Map CAPS LOCK to behave as ESC and as CTRL
if pgrep -x "xcape" > /dev/null; then pkill xcape; fi
xcape -e 'Control_L=Escape'
