# -------------------------------------------------
# file:     ~/.xinitrc
# author:   jason ryan http://jasonwryan.com/
# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=sh:
# -------------------------------------------------

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# load gnome-keyring without gnome
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

#fix owncloud keychain https://github.com/owncloud/client/issues/3726
#dbus-update-activation-environment --systemd DISPLAY

dunst &

# load .Xresources
xrdb -merge $HOME/.Xresources 

# add in fonts
xset +fp /usr/share/fonts/local  
xset +fp /home/frank604/.fonts
xset fp rehash

# turn off dpms and disable screen saver blanking
xset dpms 0 0 0 && xset s noblank && xset s off   

#turn on mpd
#mpd ~/.mpd/mpd.conf 

#turn on procmail
#procmail & 

# brightness
xbacklight -set 45% &

# set wallpaper
#feh --bg-tile '/home/frank604/Pictures/train.jpg' &

# set cursor
xsetroot -cursor_name left_ptr &

# hide cursor
unclutter -noevents -idle 5 &


# clipboard synching
autocutsel -fork &
#autocutsel -selection PRIMARY -fork &

dropbox &
compton -cCGfF -o 0.38 -O 200 -I 200 -t 0 -l 0 -r 3 -D2 -m 0.88 &

#xautolock -detectsleep \
 #             -notify  120 -notifier "xset dpms force off" \
 #             -time     10 -locker   "i3lock-fancy" & 
              #-killtime 10 -killer   "systemctl suspend" &

xautolock -detectsleep -corners -000 -notify 120 -notifier "notify-send 'The system is going down...'" -time 10 -locker "i3lock-fancy" & -killtime 10 -killer "systemctl suspend" &

autorandr --change
nitrogen --restore 
pkill mpd

# ---- Autostart xbindkeys -----
#xbindkeys &
sxhkd -c /home/frank604/.config/sxhkd/sxhkdrc &
numlockx &

# ---- window manager ----
# launch dwm
#exec dwm
exec $HOME/src/scripts/dwm-start
#export DISPLAY=:0
#exec startkde
#exec i3

