#!/usr/bin/env bash
#
# runner.sh : script for searching a proper alias to run based on argument
#
# Ref.: dotfiles/template/run-on-demand/runner.sh

# Usage: bash runner.sh <prompt>

if [ -f ~/.bash_aliases ]; then source ~/.bash_aliases; fi
if [ -f ~/.bash_snowflake ]; then source ~/.bash_snowflake; fi

app=$1; shift
alias=$(alias -p | cut -c 7- | grep $app | awk -F = '{ print $2 }' | tr -d "'")
echo $alias
echo $@

$($alias $@)
