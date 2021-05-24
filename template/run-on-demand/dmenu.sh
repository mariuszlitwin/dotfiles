#!/usr/bin/env bash
#
# dmenu.sh : script for starting various app menus in consistent way
#
# Ref.: dotfiles/template/run-on-demand/dmenu.sh

# Usage: bash dmenu.sh <prompt>

prompt=$1; shift
in=$(cat)

echo "$in" | rofi -dmenu -p "$prompt" $@
