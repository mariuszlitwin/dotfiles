#!/usr/bin/env bash
#
# .bashrc : DO NOT EDIT -- this file has been generated automatically
#
# Ref.: dotfiles/template/bash/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Is current terminal able to display color?
if [ -x /run/current-system/sw/bin/tput ] && tput setaf 1 >& /dev/null; then
  export IS_COLOR_TERM=true
else
  export IS_COLOR_TERM=false
fi;

# Change default colors on default TTY
if [ "$TERM" = "linux" ] && [ -f ~/.Xresources ] && [[ "$IS_COLOR_TERM" = true ]]; then
  for i in $(grep color "/etc/X11/xresources" | sed 's/^\*color//g' | sed 's/:\ *#/ /g' | awk '{ printf "\\e]P%X%s", $1, $2 }' ); do
    echo -en "$i"
  done
  clear
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Environment variable definitions.
# You may want to put all your environment variables into a separate file
# like ~/.bash_env, instead of adding them here directly.
if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

# Prompt definition.
# You may want to put all your prompt info into a separate file like
# ~/.bash_prompt, instead of adding them here directly.
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi


