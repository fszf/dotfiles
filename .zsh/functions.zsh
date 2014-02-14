#-------------------------------------------------
# file:     ~/.config/zsh/functions
# author:   jason ryan - http://jasonwryan.com/
# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=zsh:
#-------------------------------------------------

# Extract Files
extract() {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}

# hostblocking
urlcheck() { sudo hostsblock-urlcheck "$1" ;}

# ssh and run application
shux() { ssh "$1" -t LANG=en_NZ.utf-8 tmux a -d ;}

# grab pid
pids() { ps aux | grep "$1" ;}

# paste to sprunge
sprung() { curl -F "sprunge=<-" http://sprunge.us <"$1" ;}

# grab list of updates
aurup() { awk '{print $2}' </tmp/aurupdates* ;}

# check pacman's log
paclog() { tail -n"$1" /var/log/pacman.log ;}

# paste from clipboard
px() { printf '%s\n' $(xsel -b); }

# scan dir for thumbs
sx() { sxiv -trq "$@" 2>/dev/null ;}

# Follow copied and moved files to destination directory
cpf() { cp "$@" && goto "$_"; }
mvf() { mv "$@" && goto "$_"; }
goto() { [ -d "$1" ] && cd "$1" || cd "$(dirname "$1")"; }

# External IP
wmip() { printf "External IP: %s\n" $(curl -s  http://ifconfig.me/) ;}

# surfraw
surf() { awk '/surf/ {printf "%s", $3}' <$HOME/Dropbox/Documents/notes/misc | xsel -b ;}

# attach tmux to existing session
mux() { [[ -z "$TMUX" ]] && { tmux attach -d || tmux -f $HOME/.tmux/conf new -s secured ;} }

# International timezone
zone() { TZ="$1"/"$2" date; }
zones() { ls /usr/share/zoneinfo/"$1" ;}

# Nice mount output
nmount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }

# Print man pages 
manp() { man -t "$@" | lpr -pPrinter; }

# Create pdf of man page - requires ghostscript and mimeinfo
manpdf() { man -t "$@" | ps2pdf - /tmp/manpdf_$1.pdf && xdg-open /tmp/manpdf_$1.pdf ;}

# wifi connect
atmos() {
 sid=$(awk '/Atmos/ {print $1}' <(wicd-cli -y -l))
 wicd-cli --wireless -n "$sid" -m Atmos -c
}

# VPN
vpnon() { sudo vpnc "$1" ; }
vpnoff() { sudo vpnc-disconnect ; }
vpnup() { pgrep vpnc >/dev/null && printf '%s\n' "Connected…" || printf '%s\n' "VPN down!" ; }

# simple notes
n() {
  local files
  files=(${@/#/$HOME/.notes/})
  ${EDITOR:-vi} $files
}

# TAB completion for notes
_notes() {
    _files -g "*" -W $HOME/.notes
}
compdef _notes n

# list notes
nls() {
  tree -CR --noreport $HOME/.notes | awk '{
      if (NF==1) print $1;
      else if (NF==2) print $2;
      else if (NF==3) printf "  %s\n", $3
    }'
}

