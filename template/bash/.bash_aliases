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

alias tm="tmux new-session -A -s"

alias stow="stow -d ~/dotfiles/build -t ~/"
alias dotfiles="python3 ~/dotfiles/rebuild.py"

alias lockscreen="mate-screensaver-command --lock"
alias screenshot="scrot ${HOME}/Pictures/%Y%m%d_%H%M_scrot.png"
alias terminal="mate-terminal"
alias browser="google-chrome"

function __bw_macro {
  if test "$1" = 'unlock'; then
    export BW_SESSION=`bw unlock --raw`
  else
    bw "$@"
  fi
}
alias pw=__bw_macro

# Wrappers to set (fs) or reset (fr) formatting
#
# Wrappers are aware of IS_COLOR_TERM variable but beyond that they are
# pretty dumb
#
# usage: fs format1 [format2 [format3 [...]]]
function fs {
  if [[ "$IS_COLOR_TERM" = true ]]; then
    while [[ $# -gt 0 ]]; do
      __format_set $1;
      shift;
    done
  fi;
}
function fr {
  if [[ "$IS_COLOR_TERM" = true ]]; then
    while [[ $# -gt 0 ]]; do
      __format_reset $1;
      shift;
    done
  fi;
}

function _prompt {
  fs fg:green
  echo    "  , ,  "
  fs fg:black bg:green
  echo -n " [?_?] "
  fr all
}

# Prompt user for a value and store it as $PROMPT env
#
# usage: prompt "What's your name?"
function prompt {
  _prompt
  echo " $1"
  read -p "$(fs fg:black bg:green) > $(fr all) " PROMPT </dev/tty
}

# Read from stdin, split by newline, ask user to pick and store the result in $BMENU env
#
# usage: bmenu "What's your favorite number?" < <(echo -e "1\n2\n\3\n")
function bmenu {
  mapfile -t opts < /dev/stdin

  _prompt
  echo " $1"
  echo ""
  for i in "${!opts[@]}"; do
    echo "$(fs fg:black bg:green) $i $(fr all) ${opts[$i]}"
  done
  echo

  read -p "$(fs fg:black bg:green) > $(fr all) " PROMPT </dev/tty
  # check if $PROMPT is an integer - stackoverflow.com/a/808740 - and if it is the array index
  if [ -n "$PROMPT" ] && [ "$PROMPT" -eq "$PROMPT" ] 2>/dev/null && [ -v opts[$PROMPT] ]; then
    export BMENU="${opts[$PROMPT]}"
  else export BMENU="$PROMPT"
  fi
}
