#-------------------------------------------------
# file:     ~/.zshrc
# author:   jason ryan - http://jasonwryan.com/
# vim:fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=zsh:
#-------------------------------------------------

autoload -U colors && colors
zmodload zsh/complist

# prompts
LPROMPT () {
PS1="┌─[%{$fg[cyan]%}%m%{$fg_bold[blue]%} %~ %{$fg_no_bold[yellow]%}%(0?..%?)%{$reset_color%}]
└─╼ "
}

# Show vi mode
function zle-line-init zle-keymap-select {
    RPS1="%{$fg[magenta]%}${${KEYMAP/vicmd/%B Command Mode %b}/(main|viins)/ }"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

LPROMPT

# completions
autoload -Uz compinit
compinit

zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' completer _expand_alias _complete _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort name
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle :compinstall filename '$HOME/.zsh/.zshrc'


# history options
export HISTFILE="$ZDOTDIR/histfile"
export HISTSIZE=10000
export SAVEHIST=$((HISTSIZE/2))
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# edit history
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

setopt autocd extendedglob nomatch completealiases
setopt correct          # try to correct spelling
setopt no_correctall    # …only for commands, not filenames

# keybinds
bindkey -v
KEYTIMEOUT=1

# fix for cursor position
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "\ep" insert-last-word
bindkey "\eq" quote-line
bindkey "\ek" backward-kill-line

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# colour coreutils
export GREP_COLOR="1;31"
alias grep="grep --color=auto"
alias "ls=ls --color=auto"
# colors for ls
if [[ -f ~/.dir_colors ]]; then
    eval $(dircolors -b ~/.dir_colors)
fi

######## Aliases ########

#The 'ls' family
#---------------------------
alias ll="ls -l --group-directories-first"
alias ls="ls -h --color"    # add colors for filetype recognition
alias la="ls -a"            # show hidden files
alias lx="ls -xb"           # sort by extension
alias lk="ls -lSr"          # sort by size, biggest last
alias lc="ls -ltcr"         # sort by and show change time, most recent last
alias lu="ls -ltur"         # sort by and show access time, most recent last
alias lt="ls -ltr"          # sort by date, most recent last
alias lm="ls -al |more"     # pipe through 'more'
alias lr="ls -lR"           # recursive ls
alias lsr="tree -Csu"       # nice alternative to 'recursive ls'

# General ------------------
alias be="bundle exec"
alias rss="newsbeuter"
alias sraw="sr archwiki"
alias wifi="wicd-curses"
alias blog="cd ~/VCS/blog"
alias updates="checkupdates"
alias tmux="tmux -f ~/.tmux/conf"
alias sent="ssh -t cent ssh -t 200"
alias dush="du -sm *|sort -n|tail"
alias fire="sudo ufw status verbose"
alias pong="ping -c 3 www.google.com"
alias socks="ssh -D 8080 -f -C -q -N 200"
alias nocomment='egrep -v "^[ \t]*#|^[ \t]*$"'
alias dmesg="export PAGER=/usr/bin/more; dmesg -H"
alias irc="rm -f $HOME/.irssi/saved_colors && irssi"
alias ttytter="Scripts/ttytter.pl -keyf=$XDG_CONFIG_HOME/ttytter/key -rc=$XDG_CONFIG_HOME/ttytter/jwr"

######## Keyboard light up/down ########
alias kbdup="kbdlight up"
alias kbddown="kbdlight down"

######## Pacman ########
# update 
alias pacup="sudo pacman -Syu"

# Remove orphans
alias orphans="pacman -Qtdq"

# sudo pacman backup packages to Dropbox
alias pacback='pacman -Qqe | grep -v "$(pacman -Qmq)" > ~/Dropbox/Freedomx/pklist-new.txt'

# ssh into droplet
alias sshserver="ssh frankshin.com -p 2222"

### Mounts ###
alias centurion="sudo mount.nfs 192.168.1.100:/home/jason /media/Centurion"
alias sentinel="sudo mount.nfs 192.168.1.200:/home/jason/Backups /media/Sentinel"

# to run bash functions
autoload bashcompinit
bashcompinit

# command not found hook
source "/usr/share/doc/pkgfile/command-not-found.zsh"

# source highlighting
#source "$ZDOTDIR"/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# functions
#if [[ -d "$ZDOTDIR" ]]; then
#  for file in "$ZDOTDIR"/*.zsh; do
#    source "$file"
#  done
#fi
