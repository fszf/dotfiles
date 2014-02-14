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

# external monitor
external=$(xrandr -q | awk '/HDMI1/ {print $2}')
if [ "$external" = connected ]; then
  xrandr --output eDP1 --mode 1600x900 --pos 0x0 --below HDMI1 \
  --output HDMI1 --mode 1680x1050 --pos 0x900
fi

# load .Xresources
xrdb -merge $HOME/.Xresources 

# add in fonts
xset +fp /usr/share/fonts/local  
xset +fp /home/frank604/.fonts
xset fp rehash

#start dropbox daemon
#dropboxd &

# turn off dpms and disable screen saver blanking
#xset -dpms 
#xset s off
#turn on screen powersave
xset +dpms 
xset dpms 0 0 300 

#turn on mpd
mpd ~/.mpd/mpd.conf 


#turn on procmail
procmail & 

# enable xbindkeys
xbindkeys   

# enable restart X
setxkbmap -option terminate:ctrl_alt_bksp

# disable CapsLock & map to Escape
setxkbmap -option caps:swapescape

# compose key
#setxkbmap -option compose:ralt

#touchpad disabled when typing
#i2 = idle time to 2 seconds 
#t tells to disable tapping/scroll but not movement
#k ignore modifier keys
#d starts as daemon
syndaemon -t -k -i 2 -d &

# brightness
xbacklight -set 45% &

# set wallpaper
#imlibsetroot -s $XDG_CONFIG_HOME/background.png &
#feh --bg-scale '/home/frank604/Pictures/greycloud.jpg' &
feh --bg-tile '/home/frank604/Pictures/grey_wash_wall/grey_wash_wall.png' &

# set cursor
xsetroot -cursor_name left_ptr &

# hide cursor
unclutter -noevents -idle 5 &

# start terminal emulation daemon
urxvtd -q -o -f &

# clipboard synching
autocutsel -fork &
autocutsel -selection PRIMARY -fork &

# auto{u}mount drives
udiskie --suppress &

# ---- window manager ----
# launch dwm
exec $HOME/Scripts/dwm-start



