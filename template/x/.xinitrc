#!/usr/bin/env sh
#
# .xinitrc : DO NOT EDIT -- this file has been generated automatically
#
# Ref.: dotfiles/template/x/.xinitrc

if [[ $DISPLAY ]] && [[ -f ~/.Xresources ]] && which xrdb > /dev/null 2>&1; then
  xrdb -merge ~/.Xresources
fi;

# Is current terminal able to display color?
if [ -x <% system.bin_path %>/tput ] && tput setaf 1 >& /dev/null; then
  export IS_COLOR_TERM=true
else
  export IS_COLOR_TERM=false
fi;

# Change default colors on default TTY
if [ "$TERM" = "linux" ] && [ -f ~/.Xresources ] && [[ "$IS_COLOR_TERM" = true ]]; then
  for i in $(grep color "~/.Xresources" | sed 's/^\*color//g' | sed 's/:\ *#/ /g' | awk '{ printf "\\e]P%X%s", $1, $2 }' ); do
    echo -en "$i"
  done
  clear
fi
