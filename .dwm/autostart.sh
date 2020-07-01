#!/bin/bash

~/.fehbg &

setxkbmap -layout rs,rs -variant latin, -option grp:win_space_toggle &

TP=`xinput | grep -i "touchpad" | grep -oP '(?<=id=)[0-9]+'` # Nalazi tacped

xinput set-prop $TP `xinput list-props $TP | grep "libinput Tapping Enabled (" | awk -F"[()]" '{print $2}'` 1 & # Podesava klik na dodir
xinput set-prop $TP `xinput list-props $TP | grep "libinput Natural Scrolling Enabled (" | awk -F"[()]" '{print $2}'` 1 & # Podesava smer skrolovanja

numlockx &

picom & 

# wait 1
# xcompmgr & 
 
xautolock -time 10 -locker slock &

slstatus &

dunst &

sudo ip link set wlp0s20u3 up &
sudo ip link set wlp19s0 down &

#bindsym XF86AudioLowerVolume exec notify-send "Volume" `amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'`
#bindsym XF86AudioRaiseVolume exec notify-send "Volume" `amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'`

# Pulse Audio controls
#bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
#bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
#bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound

# Sreen brightness controls
#bindsym XF86MonBrightnessUp exec xbacklight -inc 20 # increase screen brightness
#bindsym XF86MonBrightnessDown exec xbacklight -dec 20 # decrease screen brightness


# Media player controls
#bindsym XF86AudioPlay exec playerctl play
#bindsym XF86AudioPause exec playerctl pause
#bindsym XF86AudioNext exec playerctl next
#bindsym XF86AudioPrev exec playerctl previous
