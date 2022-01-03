# i3 config file (v4)
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

# Set mod key (Mod1=<Alt>, Mod4=<Super>)
set $mod Mod4

# Configure border style <normal|1pixel|pixel xx|none|pixel>
default_border pixel 2
default_floating_border pixel 2

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font xft:Iosevka 15

# Use Mouse+$mod to drag floating windows
floating_modifier $mod

# Applications shortcuts
# Terminal
bindsym $mod+Return exec st
# Mail client
bindsym $mod+m exec mailspring
# Editor
bindsym $mod+e exec "emacsclient -c -a ''"
# Launcher
bindsym $mod+space exec "rofi -no-default-config -no-fixed-num-lines -drun-display-format {name} -display-drun 'λ' -modi drun,window,emoji -show drun -font 'Iosevka 30' -yoffset 256 -location 2"
# Telegram
bindsym $mod+t exec telegram-desktop
# Screenshot
bindsym Print exec flameshot gui
# Kill focused window
bindsym $mod+q kill
# Fullscreen screenshot
bindsym $mod+s exec scrot

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# workspace back and forth (with/without active container)
workspace_auto_back_and_forth no

# split orientation
bindsym $mod+backslash split h;exec notify-send 'tile horizontally'
bindsym $mod+slash split v;exec notify-send 'tile vertically'

# toggle fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# toggle tiling / floating
bindsym $mod+Shift+f floating toggle

# Workspace names
# to display names or symbols instead of plain workspace numbers you can use
# something like: set $ws1 1:mail
#                 set $ws2 2:
set $ws1 1
set $ws2 2
set $ws3 3
set $ws4 4
set $ws5 5
set $ws6 6
set $ws7 7
set $ws8 8

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8

# Move focused container to workspace
bindsym $mod+Ctrl+1 move container to workspace $ws1
bindsym $mod+Ctrl+2 move container to workspace $ws2
bindsym $mod+Ctrl+3 move container to workspace $ws3
bindsym $mod+Ctrl+4 move container to workspace $ws4
bindsym $mod+Ctrl+5 move container to workspace $ws5
bindsym $mod+Ctrl+6 move container to workspace $ws6
bindsym $mod+Ctrl+7 move container to workspace $ws7
bindsym $mod+Ctrl+8 move container to workspace $ws8

# Move to workspace with focused container
bindsym $mod+Shift+1 move container to workspace $ws1; workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2; workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3; workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4; workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5; workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6; workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7; workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8; workspace $ws8

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# Set window resizing controls
bindsym $mod+Shift+Ctrl+h resize shrink width 3 px or 3 ppt
bindsym $mod+Shift+Ctrl+j resize grow height 3 px or 3 ppt
bindsym $mod+Shift+Ctrl+k resize shrink height 3 px or 3 ppt
bindsym $mod+Shift+Ctrl+l resize grow width 3 px or 3 ppt

bindsym $mod+Shift+Ctrl+Left resize shrink width 3 px or 3 ppt
bindsym $mod+Shift+Ctrl+Down resize grow height 3 px or 3 ppt
bindsym $mod+Shift+Ctrl+Up resize shrink height 3 px or 3 ppt
bindsym $mod+Shift+Ctrl+Right resize grow width 3 px or 3 ppt

# Autostart applications
exec_always --no-startup-id "~/.config/polybar/launch.sh"

set_from_resource $term_background background
set_from_resource $term_foreground foreground
set_from_resource $term_color0     color0
set_from_resource $term_color1     color1
set_from_resource $term_color2     color2
set_from_resource $term_color3     color3
set_from_resource $term_color4     color4
set_from_resource $term_color5     color5
set_from_resource $term_color6     color6
set_from_resource $term_color7     color7
set_from_resource $term_color8     color8
set_from_resource $term_color9     color9
set_from_resource $term_color10    color10
set_from_resource $term_color11    color11
set_from_resource $term_color12    color12
set_from_resource $term_color13    color13
set_from_resource $term_color14    color14
set_from_resource $term_color15    color15

# Theme colors
# class                  border  backgr. text    indic.   child_border
client.focused          #373b41 #373b41 #373b41 #373b41
client.focused_inactive #202225 #202225 #c5c8c6 #373b41
client.unfocused        #202225 #202225 #c5c8c6 #202225
client.urgent           #202225 #202225 #c5c8c6 #202225
client.placeholder      #000000 #0c0c0c #c5c8c6 #000000 
client.background       #151515

# Set inner/outer gaps
gaps inner 8
gaps outer 0
