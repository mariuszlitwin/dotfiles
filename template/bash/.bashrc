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

# Run xinitrc
# I'm not sure if it's necessary but I want my environment
# variables set properly for sure
if [ -f ~/.xinitrc ]; then
    . ~/.xinitrc
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
