#!/usr/bin/env bash
#
# .bash_aliases : DO NOT EDIT -- this file has been generated automatically
#
# Ref.: dotfiles/template/bash/.bash_aliases

alias ls="ls -lhFAC"
alias mkdir="mkdir -pv"

alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mt"

alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

alias cls="clear"

alias gpg="gpg2"

alias myip="curl http://ipecho.net/plain; echo"

alias xclip="xclip -selection clipboard"

alias stow="stow -d ~/dotfiles/build -t ~/"
alias dotfiles="perl ~/dotfiles/rebuild.pl"

alias lockscreen="mate-screensaver-command --lock"
alias screenshot="scrot ${HOME}/Pictures/%Y%m%d_%H%M_scrot.png"
alias terminal="mate-terminal"
alias browser="firefox"

__bw_macro() {
  if test "$1" = 'unlock'; then
    export BW_SESSION=`bw unlock --raw`
  else
    bw "$@"
  fi
}
alias pw=__bw_macro
