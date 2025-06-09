#!/usr/bin/env sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
xdgconfighome=$HOME/.config

# merge in defaults and keymaps
if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Scale QT Applications
export QT_SCALE_FACTOR=1.5

# Export XDG_CONFIG_HOME
export XDG_CONFIG_HOME=$xdgconfighome
export XDG_CURRENT_DESKTOP=i3

# Merge Xresources
xrdb -merge ~/.Xresources

# Disable touchpad
# xinput disable 11

# Set keyring daemon
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

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

# Wallpaper management
# ~/.fehbg &
hsetroot -solid "#151515"

# Start cadence & JACK
# cadence-session-start --system-start &

# Start network-manager-applet
# Poor documented dependency of protonvpn
nm-applet &

# Load pulseaudio modules
pacmd load-module module-bluetooth-policy
pacmd load-module module-bluetooth-discover

# Desktop environment
exec i3
