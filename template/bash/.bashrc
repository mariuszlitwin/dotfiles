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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%y-%m-%d %T "

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

# Enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Machine-specific settings
# You may want to put machine-specific bash settings into a separate file
# like ~/.bash_snowflake, instead of adding them here directly.
if [ -f ~/.bash_snowflake ]; then
  . ~/.bash_snowflake
fi

# Make GPG default SSH key provider
if command -v gpg2 &> /dev/null && [ -z ${NO_GPG_SSH+x} ]
then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  echo UPDATESTARTUPTTY | gpg-connect-agent &> /dev/null
fi

export PATH="/bin:$PATH"
if command -v pyenv &> /dev/null && [ -z ${NO_PYENV+x} ]
then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

[ -f /opt/conda/etc/profile.d/conda.sh ] && source  /opt/conda/etc/profile.d/conda.sh

if command -v t &> /dev/null && [ -n "$PS1" ] &&
   [[ ! "$TERM_PROGRAM" == "vscode" ]] &&
   [[ ! "$TERM" =~ screen ]] &&
   [[ ! "$TERM" =~ tmux ]] &&
   [ -z "$TMUX" ]
then
  t new-session -d -s dancefloor > /dev/null 2>&1
  bmenu "Pick tmux session or name the new one" < <(t list-sessions -F "#{session_name}")
  t new-session -A -s $BMENU
  export -n BMENU PROMPT
elif [[ "$TERM_PROGRAM" == "vscode" ]]; then
  t new-session -A -s visual-studio-code
fi
